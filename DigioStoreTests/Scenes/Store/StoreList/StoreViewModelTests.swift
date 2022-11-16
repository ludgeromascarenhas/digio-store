import XCTest

@testable import DigioStore

// MARK: - StoreViewModelTests

final class StoreViewModelTests: XCTestCase {
  
  // MARK: - Private variables
  
  private var sut: StoreViewModel!
  private var service: StoreServiceMock!
  private var coordinator: StoreCoordinatorSpy!
  
  // MARK: - Override methods
  
  override func setUp() {
    super.setUp()
    service = StoreServiceMock()
    coordinator = StoreCoordinatorSpy()
    sut = StoreViewModel(service: service,
                         coordinator: coordinator)
  }
  
  override func tearDown() {
    super.tearDown()
    sut = nil
    service = nil
    coordinator = nil
  }
  
  private func handleAsyncExpectations() {
    let expectation = expectation(description: "")
    DispatchQueue.main.async {
      expectation.fulfill()
    }
    waitForExpectations(timeout: 0.1, handler: nil)
  }
  
  func testInit() {
    sut.fetchStore()
    RunLoop.current.run(until: Date())
    handleAsyncExpectations()
    print(sut.storeSections.count)
    XCTAssert(!sut.storeSections.isEmpty)
  }
  
  func testFail() {
    service.callbackSuccess = false
    sut.fetchStore()
    RunLoop.current.run(until: Date())
    handleAsyncExpectations()
    XCTAssert(sut.storeSections.isEmpty)
  }
  
  func testEmptyData() {
    service.shouldShowEmptyData = true
    sut.fetchStore()
    RunLoop.current.run(until: Date())
    XCTAssert(sut.storeSections.isEmpty)
  }
  
  func testRouteToDetailsWhenRouteIsCalled() {
    let mock = Item(title: "Mock",
                    imageURL: "https://mock.com",
                    description: "Mock")
    sut.routeToDetails(selectedItem: mock)
    XCTAssert(coordinator.didCallRouteToDetails)
  }
}
