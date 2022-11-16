import UIKit

@testable import DigioStore

// MARK: - StoreCoordinatorSpy

final class StoreCoordinatorSpy: StoreCoordinatorProtocol {
  
  var didCallRouteToDetails = false
  var children: [DigioStore.CoordinatorProtocol] = []
  var navigationController = UINavigationController()
  var parent: DigioStore.CoordinatorProtocol?
  
  func routeToDetails(item: Item) {
    didCallRouteToDetails = true
  }
  func start() {}
  func routeToStore() {}
}
