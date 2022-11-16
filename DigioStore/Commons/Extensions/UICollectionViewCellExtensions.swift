import UIKit

// MARK: - UICollectionViewCell

extension UICollectionViewCell {
  
  func setCornerRadiusAndShadow(cornerRadius: CGFloat = 12,
                                shadowColor: UIColor = .gray) {
    
    layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
    layer.masksToBounds = false
    layer.shadowOffset = CGSize(width: 0, height: 0.1)
    layer.shadowColor = shadowColor.cgColor
    layer.shadowOpacity = 0.5
  }
}
