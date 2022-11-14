import UIKit

// MARK: - UIImageViewExtensions

extension UIImageView {
  
  func load(url: URL) {
    DispatchQueue.global().async { [weak self] in
      if let data = try? Data(contentsOf: url) {
        if let image = UIImage(data: data) {
          DispatchQueue.main.async {
            self?.image = image
          }
        }
      } else {
        let image = UIImage(imageLiteralResourceName: "notFound")
        DispatchQueue.main.async {
          self?.image = image
        }
      }
    }
  }
}
