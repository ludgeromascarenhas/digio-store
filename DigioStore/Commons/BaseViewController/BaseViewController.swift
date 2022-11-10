import UIKit

// MARK: - BaseViewController

class BaseViewController<View: UIView>: UIViewController {
  
  // MARK: - Internal variables
  
  // swiftlint:disable force_cast
  var customView: View {
    return view as! View
  }
  // swiftlint:enable force_cast
  
  // MARK: - Initializers
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Override methods
  
  override func loadView() {
    view = View()
  }
}
