import Foundation

@testable import DigioStore

// MARK: - StoreServiceMock

final class StoreServiceMock: StoreServiceProtocol {
  
  var callbackSuccess: Bool = true
  var error = ResponseError(message: "Error mock")
  var shouldShowEmptyData: Bool = false
  
  func fetchStore(completion: @escaping (Result<Store, ResponseError>) -> Void) {
    
    if shouldShowEmptyData {
      completion(.success(Store(spotlight: nil,
                                products: nil,
                                cash: nil)))
    }
    
    if callbackSuccess {
      completion(.success(getResponseMock()!))
    } else {
      completion(.failure(error))
    }
  }
  
  func getResponseMock() -> Store? {
    let jsonDecoder = JSONDecoder()
    if let json = self.loadJson(from: "DigioStore"),
       let data = try? jsonDecoder.decode(Store.self, from: json) {
      return data
    }
    return nil
  }
  
  func loadJson(from filename: String) -> Data? {
    guard
      let path =  Bundle(for: type(of: self)).path(forResource: filename, ofType: "json"),
      let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
    else { return nil }
    return data
  }
}
