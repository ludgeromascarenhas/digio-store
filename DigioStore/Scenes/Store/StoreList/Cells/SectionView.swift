import UIKit

// MARK: - SectionView

final class SectionView: UIView {
  
  // MARK: - Private variables
  
  private let titleLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.numberOfLines = 1
    $0.textAlignment = .left
    $0.font = .boldSystemFont(ofSize: 20)
    $0.textColor = DSColors.blue.color
    return $0
  }(UILabel())
  
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

extension SectionView {
  
  func configure(sectionType: StoreSectionType) {
    if sectionType == .cashDigio {
      setupDigioCashTitle(title: sectionType.title)
      return
    }
    titleLabel.text = sectionType.title
  }
}

// MARK: - Private methods

private extension SectionView {
  
  func setupDigioCashTitle(title: String) {
    let attributedString = NSMutableAttributedString(string: title)
    attributedString.setColorForText(textForAttribute: "digio", withColor: DSColors.blue.color)
    attributedString.setColorForText(textForAttribute: "Cash", withColor: DSColors.gray.color)
    titleLabel.attributedText = attributedString
  }
  
  func setupLayout() {
    backgroundColor = .white
    addComponents()
  }
  
  func addComponents() {
    addSubview(titleLabel)
    setupTitleLabelConstraints()
  }
  
  func setupTitleLabelConstraints() {
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: topAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
    ])
  }
}
