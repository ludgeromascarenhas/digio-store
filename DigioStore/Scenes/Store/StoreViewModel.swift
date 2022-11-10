import Foundation

// MARK: - StoreViewModelProtocol

protocol StoreViewModelProtocol: AnyObject {
  func fetchStore()
}

// MARK: - StoreViewModel

final class StoreViewModel: StoreViewModelProtocol {
  
  // MARK: - Private variables
  
  private let service: StoreServiceProtocol
  private let coordinator: StoreCoordinatorProtocol
  
  // MARK: - Initializers
  
  init(service: StoreServiceProtocol = StoreService(), coordinator: StoreCoordinatorProtocol) {
    self.service = service
    self.coordinator = coordinator
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
