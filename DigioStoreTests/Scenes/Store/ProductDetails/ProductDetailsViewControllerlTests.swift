import XCTest

@testable import DigioStore

// MARK: - StoreCoordinatorTests

final class ProductDetailsViewControllerlTests: XCTestCase {
  
  // MARK: - Private variables
  
  private var sut: ProductDetailsViewController!
  private var viewModel: ProductDetailsViewModelProtocol!
  
  // MARK: - Override methods
  
  override func setUp() {
    super.setUp()
    viewModel = ProductDetailsViewModelMock()
    sut = ProductDetailsViewController(viewModel: viewModel)
    sut.loadViewIfNeeded()
  }
  
  override func tearDown() {
    super.tearDown()
    sut = nil
  }
  
  // MARK: - Internal methods
  
  func testTitleIsNotNilAndRightWhenSceneAppear() {
    XCTAssertEqual(sut.title, "Mock")
  }
  
  func testDescriptionIsNotNilAndRightWhenSceneAppear() {
    XCTAssertEqual(sut.customView.descriptionLabel.text, "Mock description")
  }
}

final class ProductDetailsViewModelMock: ProductDetailsViewModelProtocol {
  
  var item: Item = Item(title: "Mock",
                        imageURL: "https://mock.com",
                        description: "Mock description")
  
  
}
