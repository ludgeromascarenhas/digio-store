import UIKit

// MARK: - StoreCoordinatorProtocol

protocol StoreCoordinatorProtocol: CoordinatorProtocol {
  func routeToStore()
}

// MARK: - StoreCoordinator

final class StoreCoordinator: StoreCoordinatorProtocol {
  
  // MARK: - Internal variables
  
  var children = [CoordinatorProtocol]()
  var navigationController: UINavigationController
  weak var parent: CoordinatorProtocol?
  
  // MARK: - Initializers
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
}

// MARK: - Internal methods

extension StoreCoordinator {
  
  func start() {
    routeToStore()
  }
  
  func routeToStore() {
    let viewModel = StoreViewModel(coordinator: self)
    let viewController = StoreViewController(viewModel: viewModel)
    navigationController.pushViewController(viewController, animated: true)
  }
}
