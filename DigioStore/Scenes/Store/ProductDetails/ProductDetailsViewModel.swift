import UIKit

// MARK: - ProductDetailsViewModelProtocol

protocol ProductDetailsViewModelProtocol: AnyObject {
  var item: Item { get }

}

// MARK: - ProductDetailsViewModel

final class ProductDetailsViewModel: ProductDetailsViewModelProtocol {
  
  // MARK: - Internal variables
  
  let item: Item
  
  // MARK: - Initializers
  
  init(item: Item) {
    self.item = item
  }
}
