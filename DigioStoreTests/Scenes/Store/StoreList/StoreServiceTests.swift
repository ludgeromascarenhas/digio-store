import XCTest

@testable import DigioStore

// MARK: - StoreServiceTests

final class StoreServiceTests: XCTestCase {
  
  // MARK: - Private variables
  
  private var service: NetworkServiceMock!
  private var sut: StoreService!
  
  // MARK: - Override methods
  
  override func setUp() {
    super.setUp()
    service = NetworkServiceMock()
    sut = StoreService(service: service)
  }
  
  override func tearDown() {
    super.tearDown()
    sut = nil
    service = nil
  }
  
  func testRequestObject() {
    sut.fetchStore { _ in
      XCTAssertEqual(self.service.request?.method, HTTPMethod.get)
      XCTAssertEqual(self.service.request?.path,
                     "https://7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com/sandbox/products")
    }
  }
}
