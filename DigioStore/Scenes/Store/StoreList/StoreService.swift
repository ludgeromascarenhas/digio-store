import Foundation

// MARK: - StoreServiceProtocol

protocol StoreServiceProtocol: AnyObject {
  func fetchStore(completion: @escaping (Result<Store, ResponseError>) -> Void)
}

// MARK: - StoreService

final class StoreService: StoreServiceProtocol {
  
  // MARK: - Private variables
  
  private let service: NetworkServiceProtocol
  
  // MARK: - Initializers
  
  init(service: NetworkServiceProtocol = NetworkService()) {
    self.service = service
  }
}

// MARK: - Internal methods

extension StoreService {
  
  func fetchStore(completion: @escaping (Result<Store, ResponseError>) -> Void) {
    let request = TesteRequest()
    service.request(request: request, completion: completion)
  }
}

// MARK: - User Request

struct TesteRequest: BaseRequestProtocol {
  var method: HTTPMethod
  var path: String
  
  init() {
    path = "https://7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com/sandbox/products"
    method = .get
  }
}

// MARK: - Store

struct Store: Decodable {
  let spotlight: [Spotlight]?
  let products: [Product]?
  let cash: Cash?
}

// MARK: - Cash

struct Cash: Decodable {
  let title: String?
  let bannerURL: String?
  let description: String?
}

// MARK: - Product

struct Product: Decodable {
  let name: String?
  let imageURL: String?
  let description: String?
}

// MARK: - Spotlight

struct Spotlight: Decodable {
  let name: String?
  let bannerURL: String?
  let description: String?
}
