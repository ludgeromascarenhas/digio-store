import Foundation

// MARK: - NetworkServiceProtocol

protocol NetworkServiceProtocol: AnyObject {
  var urlSession: URLSession { get }
  
  @discardableResult
  func request<R: Decodable>(request: BaseRequestProtocol,
                             completion: @escaping (Result<R, ResponseError>) -> Void) -> URLSessionDataTask?
}

// MARK: - NetworkService

class NetworkService: NetworkServiceProtocol {
  
  // MARK: - Internal variables
  
  let urlSession: URLSession
  
  // MARK: - Private variables
  
  private var acceptedStatusCodes: [Int] = Array(200..<300)
  
  // MARK: - Initializer
  
  init(urlSession: URLSession = URLSession.shared) {
    self.urlSession = urlSession
  }
}

// MARK: - Internal methods

extension NetworkService {
  
  func request<R: Decodable>(request: BaseRequestProtocol,
                             completion: @escaping (Result<R, ResponseError>) -> Void) -> URLSessionDataTask? {
    guard
      let request: URLRequest = makeRequest(with: request)
    else {
      completion(.failure(createGenericError()))
      return nil
    }
    
    return dataTask(for: request) { result in
      switch result {
      case let .success(data):
        do {
          let object = try JSONDecoder().decode(R.self, from: data)
          completion(.success(object))
        } catch {
          let error = self.errorHandler(by: data)
          completion(.failure(error))
        }
      case let .failure(error):
        completion(.failure(error))
      }
    }
  }
  
  func dataTask(for request: URLRequest,
                completion: @escaping ((Result<Data, ResponseError>) -> Void)) -> URLSessionDataTask? {
    let task = urlSession.dataTask(with: request) { [weak self] (data, taskResponse, error)  in
      guard let self = self else { return }
      if error != nil {
        let error = self.errorHandler(by: data)
        completion(.failure(error))
      }
      
      if let data = data {
        if let response = taskResponse as? HTTPURLResponse {
          if !self.acceptedStatusCodes.contains(response.statusCode) {
            completion(.failure(self.errorHandler(by: data)))
          }
        }
        completion(.success(data))
      }
    }
    task.resume()
    return task
  }
  
  func makeRequest(with data: BaseRequestProtocol) -> URLRequest? {
    guard
      let url = URL(string: data.path)
    else { return nil }
    
    var request = URLRequest(url: url)
    request.httpMethod = data.method.rawValue
    return request
  }
  
  func createGenericError() -> ResponseError {
    return ResponseError(message: DSStrings.somethingWrong)
  }
  
  func errorHandler(by data: Data?) -> ResponseError {
    if let data = data {
      do {
        let error = try JSONDecoder().decode(ResponseError.self, from: data)
        return error
      } catch {
        return createGenericError()
      }
    } else {
      return createGenericError()
    }
  }
}

// MARK: - Error Struct

struct ResponseError: Decodable, Error {
  let message: String
}
