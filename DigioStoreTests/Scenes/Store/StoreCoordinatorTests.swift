import XCTest

@testable import DigioStore

// MARK: - StoreCoordinatorTests

final class StoreCoordinatorTests: XCTestCase {
  
  // MARK: - Private variables
  
  private var sut: StoreCoordinator!
  private var navigationController: UINavigationController!
  private var window: UIWindow!
  
  // MARK: - Override methods
  
  override func setUp() {
    super.setUp()
    navigationController = UINavigationController()
    sut = StoreCoordinator(navigationController: navigationController)
    
    window = UIWindow()
    window.rootViewController = sut.navigationController
    window.makeKeyAndVisible()
  }
  
  override func tearDown() {
    super.tearDown()
    sut = nil
    navigationController = nil
    window = nil
  }
  
  // MARK: - Internal methods
  
  func testRightSceneWhenCoordinatorIsStarted() {
    sut.start()
    XCTAssertNotNil(navigationController.visibleViewController is StoreViewController)
  }
  
  func testDetailsSceneWhenRouteTodetailsIsCalled() {
    let item = Item(title: "Test",
                    imageURL: "www.test.com",
                    description: "Description Test")
    sut.routeToDetails(item: item)
    XCTAssertNotNil(navigationController.visibleViewController is ProductDetailsViewController)
  }
}
