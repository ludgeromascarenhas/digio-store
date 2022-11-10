import Foundation

// MARK: - StoreViewModelProtocol

protocol StoreViewModelProtocol: AnyObject {
  func fetchStore()
}

// MARK: - StoreViewModel

final class StoreViewModel: StoreViewModelProtocol {
  
  // MARK: - Private variables
  
  private let service: StoreServiceProtocol
  
  // MARK: - Initializers
  
  init(service: StoreServiceProtocol = StoreService()) {
    self.service = service
  }
}

// MARK: - Internal methods

extension StoreViewModel {
  
  func fetchStore() {
    service.fetchStore { result in
      switch result {
      case .success(let response):
        print(response)
      case .failure(let error):
        print(error)
      }
    }
  }
}
