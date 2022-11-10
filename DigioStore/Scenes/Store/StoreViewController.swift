import UIKit

// MARK: - StoreViewController

final class StoreViewController: BaseViewController<StoreView> {
  
  // MARK: - Private variables
  
  private let viewModel: StoreViewModelProtocol
  
  // MARK: - Initializers
  
  init(viewModel: StoreViewModelProtocol) {
      self.viewModel = viewModel
      super.init()
  }
  
  // MARK: - Override methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.fetchStore()
  }
}
