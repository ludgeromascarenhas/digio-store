import XCTest

@testable import DigioStore

// MARK: - StoreViewControllerTests

final class StoreViewControllerTests: XCTestCase {
  
  // MARK: - Private variables
  
  private var sut: StoreViewController!
  private var viewModel: StoreViewModel!
  private var service: StoreServiceMock!
  private var coordinator: StoreCoordinatorProtocol!
  
  // MARK: - Override methods
  
  override func setUp() {
    super.setUp()
    service = StoreServiceMock()
    service.shouldShowEmptyData = true
    let navigationController = UINavigationController()
    coordinator = StoreCoordinator(navigationController: navigationController)
    viewModel = StoreViewModel(service: service,
                               coordinator: coordinator)
    sut = StoreViewController(viewModel: viewModel)
    viewModel.delegate = sut
  }
  
  override func tearDown() {
    super.tearDown()
    sut = nil
    viewModel = nil
  }
  
  private func handleAsyncExpectations() {
    let expectation = expectation(description: "")
    DispatchQueue.main.async {
      expectation.fulfill()
    }
    waitForExpectations(timeout: 0.1, handler: nil)
  }
  
  func testTitleIsNotEmpty() {
    sut.loadViewIfNeeded()
    RunLoop.current.run(until: Date())
    handleAsyncExpectations()
    XCTAssertNotNil(sut.title)
    XCTAssertEqual(sut.title, "Digio Store")
  }
  
  func testViewForHeaderInOthersSectionsShouldBeNil() {
    sut.loadViewIfNeeded()
    RunLoop.current.run(until: Date())
    handleAsyncExpectations()
    let header = sut.tableView(sut.customView.tableView,
                               viewForHeaderInSection: 0)
    XCTAssertNil(header)
  }
  
  func testViewForHeaderInOthersSectionsShouldNotBeNil() {
    sut.loadViewIfNeeded()
    RunLoop.current.run(until: Date())
    handleAsyncExpectations()
    let headerSection1 = sut.tableView(sut.customView.tableView,
                                       viewForHeaderInSection: 1)
    XCTAssertNotNil(headerSection1)
    
    let headerSection2 = sut.tableView(sut.customView.tableView,
                                       viewForHeaderInSection: 2)
    XCTAssertNotNil(headerSection2)
  }
  
  func testNumberOfRowsShouldBeAlwaysOne() {
    sut.loadViewIfNeeded()
    RunLoop.current.run(until: Date())
    handleAsyncExpectations()
    XCTAssertEqual(sut.tableView(sut.customView.tableView,
                                 numberOfRowsInSection: 0), 1)
    XCTAssertEqual(sut.tableView(sut.customView.tableView,
                                 numberOfRowsInSection: 1), 1)
    XCTAssertEqual(sut.tableView(sut.customView.tableView,
                                 numberOfRowsInSection: 2), 1)
  }
  
  func testHeightForHeaderForAllSectionsShouldBe32() {
    sut.loadViewIfNeeded()
    RunLoop.current.run(until: Date())
    handleAsyncExpectations()
    XCTAssertEqual(sut.tableView(sut.customView.tableView,
                                 heightForHeaderInSection: 0), 32)
    XCTAssertEqual(sut.tableView(sut.customView.tableView,
                                 heightForHeaderInSection: 1), 32)
    XCTAssertEqual(sut.tableView(sut.customView.tableView,
                                 heightForHeaderInSection: 2), 32)
  }
  
  func testHeightForRow() {
    sut.loadViewIfNeeded()
    RunLoop.current.run(until: Date())
    handleAsyncExpectations()
    XCTAssertEqual(sut.tableView(sut.customView.tableView,
                                 heightForRowAt: IndexPath(row: 0, section: 0)), 200)
    XCTAssertEqual(sut.tableView(sut.customView.tableView,
                                 heightForRowAt: IndexPath(row: 0, section: 1)), 120)
    XCTAssertEqual(sut.tableView(sut.customView.tableView,
                                 heightForRowAt: IndexPath(row: 0, section: 2)), 120)
  }
  
  func testShouldShowMessageError() {
    service.callbackSuccess = false
    sut.loadViewIfNeeded()
    RunLoop.current.run(until: Date())
    handleAsyncExpectations()
  }
  
  func testShouldShowEmptyData() {
    service.shouldShowEmptyData = true
    sut.loadViewIfNeeded()
    RunLoop.current.run(until: Date())
    handleAsyncExpectations()
  }
}
