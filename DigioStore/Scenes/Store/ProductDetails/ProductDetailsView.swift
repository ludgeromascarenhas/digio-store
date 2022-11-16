import UIKit

// MARK: - ProductDetailsView

final class ProductDetailsView: UIView {
  
  // MARK: - Private variables
  
  let productImageView: UIImageView = {
    $0.contentMode = .scaleAspectFit
    return $0
  }(UIImageView())
  
  private let descriptionView = UIView()
  
  let descriptionLabel: UILabel = {
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
  
  private let scrollView: UIScrollView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    return $0
  }(UIScrollView())
  
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
    setupScrollViewConstraints()
    setupStackViewConstraints()
    setupDescriptionLabel()
    setupProductImageViewConstraint()
  }
  
  func addComponents() {
    addSubview(scrollView)
    scrollView.addSubview(stackView)
    descriptionView.addSubview(descriptionLabel)
    stackView.addArrangedSubview(productImageView)
    stackView.addArrangedSubview(descriptionView)
  }
  
  func setupScrollViewConstraints() {
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
      scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
      scrollView.leadingAnchor.constraint(equalTo: leadingAnchor)
    ])
  }
  
  func setupStackViewConstraints() {
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
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
