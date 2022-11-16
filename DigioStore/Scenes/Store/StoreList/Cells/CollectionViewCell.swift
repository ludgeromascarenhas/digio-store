import UIKit

// MARK: - CollectionViewCell

final class CollectionViewCell: UICollectionViewCell {
  
  // MARK: - Internal variables
  
  static let identifier = String(describing: CollectionViewCell.self)
  
  // MARK: - Private variables
  
  private let stackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    return $0
  }(UIStackView())
  
  private let iconImageView: UIImageView = {
    $0.layer.cornerRadius = 12
    $0.layer.masksToBounds = true
    return $0
  }(UIImageView())
  
  // MARK: - Initializers
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Internal methods

extension CollectionViewCell {
  
  func configure(data: String?) {
    guard
      let urlString = data,
      let url = URL(string: urlString)
    else { return }
    iconImageView.load(url: url)
    setCornerRadiusAndShadow()
  }
}

// MARK: - Private methods

private extension CollectionViewCell {
  
  func setupLayout() {
    addComponents()
    setupStackViewConstraints()
  }
  
  func addComponents() {
    contentView.addSubview(stackView)
    stackView.addArrangedSubview(iconImageView)
  }
  
  func setupStackViewConstraints() {
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
      stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
    ])
  }
}
