import UIKit

// MARK: - ProductDetailsView

final class ProductDetailsView: UIView {
  
  // MARK: - Private variables
  
  private let productImageView: UIImageView = {
    $0.contentMode = .scaleAspectFit
    return $0
  }(UIImageView())
  
  private let descriptionView: UIView = {
    return $0
  }(UIView())
  
  private let descriptionLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.numberOfLines = 0
    return $0
  }(UILabel())
  
  private let stackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .vertical
    $0.spacing = 8
    return $0
  }(UIStackView())
  
  // MARK: - Initializers
  
  init() {
    super.init(frame: .zero)
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Internal methods

extension ProductDetailsView {
  
  func configure(description: String, url: URL) {
    productImageView.load(url: url)
    descriptionLabel.text = description
  }
}

// MARK: - Private methods

private extension ProductDetailsView {
  
  func setupLayout() {
    backgroundColor = .white
    addComponents()
    setupStackViewConstraints()
    setupDescriptionLabel()
    setupProductImageViewConstraint()
  }
  
  func addComponents() {
    addSubview(stackView)
    descriptionView.addSubview(descriptionLabel)
    stackView.addArrangedSubview(productImageView)
    stackView.addArrangedSubview(descriptionView)
  }
  
  func setupStackViewConstraints() {
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 64),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
    ])
  }
  
  func setupDescriptionLabel() {
    NSLayoutConstraint.activate([
      descriptionLabel.topAnchor.constraint(equalTo: descriptionView.topAnchor),
      descriptionLabel.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor),
      descriptionLabel.bottomAnchor.constraint(equalTo: descriptionView.bottomAnchor),
      descriptionLabel.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor)
    ])
  }
  
  func setupProductImageViewConstraint() {
    NSLayoutConstraint.activate([
      productImageView.heightAnchor.constraint(equalToConstant: 200),
      productImageView.widthAnchor.constraint(equalToConstant: 200)
    ])
  }
}
