import UIKit

// MARK: - ProductDetailsViewController

final class ProductDetailsViewController: BaseViewController<ProductDetailsView> {
  
  // MARK: - Private variables
  
  private let viewModel: ProductDetailsViewModelProtocol
  
  // MARK: - Initializers
  
  init(viewModel: ProductDetailsViewModelProtocol) {
    self.viewModel = viewModel
    super.init()
  }
  
  // MARK: - Override methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setValues()
  }
}

// MARK: - Internal methodsd

extension ProductDetailsViewController {
  
  func setValues() {
    let item = viewModel.item
    title = item.title
    guard
      let urlString = item.imageURL,
      let url = URL(string: urlString),
      let description = item.description
    else { return }
    customView.configure(description: description,
                         url: url)
  }
}
