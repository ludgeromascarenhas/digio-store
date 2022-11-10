import UIKit

// MARK: - StoreView

final class StoreView: UIView {
  
  // MARK: - Initializers
  
  init() {
    super.init(frame: .zero)
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Private methods

private extension StoreView {
  
  func setupLayout() {
    backgroundColor = UIColor.red
  }
}
