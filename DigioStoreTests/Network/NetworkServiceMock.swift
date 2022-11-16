import Foundation

@testable import DigioStore

// MARK: - NetworkServiceMock

final class NetworkServiceMock: NetworkServiceProtocol {
  var urlSession: URLSession = .shared
  
  var resultDataTask: Result<Data, ResponseError> = .success(Data())
  var request: BaseRequestProtocol?
  
  func request<R>(request: BaseRequestProtocol,
                  completion: @escaping (Result<R, ResponseError>) -> Void) -> URLSessionDataTask? where R : Decodable {
    
    saveRequestObject(request: request)
    
    switch resultDataTask {
    case let .success(data):
      do {
        let object = try JSONDecoder().decode(R.self, from: data)
        completion(.success(object))
      } catch {
        completion(.failure(createGenericErrorMock()))
      }
    case let .failure(error):
      completion(.failure(error))
    }
    return nil
  }
  
  func createGenericErrorMock() -> ResponseError {
    return ResponseError(message: DSStrings.somethingWrong)
  }
  
  func saveRequestObject(request: BaseRequestProtocol) {
    self.request = request
  }
}
