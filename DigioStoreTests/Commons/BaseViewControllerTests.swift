import XCTest
import UIKit

@testable import DigioStore

// MARK: - BaseViewControllerTests

final class BaseViewControllerTests: XCTestCase {
  
  // MARK: - Private variables
  
  private var sut: BaseViewController<DummyBaseView>!
  
  // MARK: - Override methods
  
  override func setUp() {
    super.setUp()
    sut = BaseViewController()
  }
  
  override func tearDown() {
    super.tearDown()
    sut = nil
  }
  
  // MARK: - Internal methods
  
  func testInitWithValueBaseView() {
    XCTAssertNotNil(sut.customView)
  }
}

// MARK: - DummyBaseView

private class DummyBaseView: UIView {}
