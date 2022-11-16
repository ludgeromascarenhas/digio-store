import UIKit

// MARK: - StoreCoordinatorProtocol

protocol StoreCoordinatorProtocol: CoordinatorProtocol {
  func routeToStore()
  func routeToDetails(item: Item)
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
    viewModel.delegate = viewController
    navigationController.pushViewController(viewController, animated: true)
  }
  
  func routeToDetails(item: Item) {
    let viewModel = ProductDetailsViewModel(item: item)
    let viewController = ProductDetailsViewController(viewModel: viewModel)
    navigationController.pushViewController(viewController, animated: true)
  }
}
