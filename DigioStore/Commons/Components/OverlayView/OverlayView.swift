import UIKit

// MARK: - OverlayView

final class OverlayView: UIView {

  // MARK: - Private variables
  
  let indicator: UIActivityIndicatorView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.startAnimating()
    return $0
  }(UIActivityIndicatorView(style: .gray))
  
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

private extension OverlayView{
  
  func setupLayout() {
    backgroundColor = .white
    addComponents()
    setupIndicatiorConstraints()
  }
  
  func addComponents() {
    addSubview(indicator)
  }
  
  func setupIndicatiorConstraints() {
    NSLayoutConstraint.activate([
      indicator.centerYAnchor.constraint(equalTo: centerYAnchor),
      indicator.centerXAnchor.constraint(equalTo: centerXAnchor)
    ])
  }
}
