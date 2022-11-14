import UIKit

// MARK: - StoreDelegate

protocol StoreDelegate: class {
  func updateTableView()
  func showEmptyDataMessage()
  func showErrorMessage()
}

// MARK: - StoreViewModelProtocol

protocol StoreViewModelProtocol: AnyObject {
  var storeSections: [StoreSection] { get }
  
  func fetchStore()
  func routeToDetails(selectedItem: Item)
}

// MARK: - StoreViewModel

final class StoreViewModel: StoreViewModelProtocol {
  
  // MARK: - Internal varaibles
  
  var data: Store?
  var storeSections: [StoreSection] = []
  
  // MARK: - Private variables
  
  private let service: StoreServiceProtocol
  private let coordinator: StoreCoordinatorProtocol
  weak var delegate: StoreDelegate?
  
  // MARK: - Initializers
  
  init(service: StoreServiceProtocol = StoreService(), coordinator: StoreCoordinatorProtocol) {
    self.service = service
    self.coordinator = coordinator
  }
}

// MARK: - Internal methods

extension StoreViewModel {
  
  func fetchStore() {
    service.fetchStore { [weak self] result in
      switch result {
      case .success(let response):
        DispatchQueue.main.async {
          self?.data = response
          self?.handleData()
        }
      case .failure(let error):
        self?.delegate?.showErrorMessage()
        // TODO: remover
        print(error)
      }
    }
  }
  
  func routeToDetails(selectedItem: Item) {
    coordinator.routeToDetails(item: selectedItem)
  }
}

// MARK: - Private methods

private extension StoreViewModel {
  
  // TODO: refatorar
  func handleData() {
    var storeItems: [Item] = []
    
    if let data = data?.spotlight {
      for spotlight in data {
        let item = Item(title: spotlight.name,
                        imageURL: spotlight.bannerURL,
                        description: spotlight.description)
        storeItems.append(item)
      }
      let section = StoreSection(key: .spotlight, value: storeItems)
      storeSections.append(section)
    }

    if let cash = data?.cash {
      storeItems = []
      let item = Item(title: cash.title,
                      imageURL: cash.bannerURL,
                      description: cash.description)
      storeItems.append(item)
      let section = StoreSection(key: .cashDigio, value: storeItems)
      storeSections.append(section)
    }

    if let products = data?.products {
      storeItems = []
      for product in products {
        let item = Item(title: product.name,
                        imageURL: product.imageURL,
                        description: product.description)
        storeItems.append(item)
      }
      let section = StoreSection(key: .products, value: storeItems)
      storeSections.append(section)
    }
    
    if storeSections.isEmpty {
      delegate?.showEmptyDataMessage()
    } else {
      delegate?.updateTableView()
    }
  }
}

// MARK: - StoreSection

struct StoreSection {
  let key: StoreSectionType
  let value: [Item]
}

struct Item {
  let title: String?
  let imageURL: String?
  let description: String?
  var image: UIImage?
}

enum StoreSectionType {
  case spotlight
  case cashDigio
  case products
  
  var title: String {
    switch self {
    case .cashDigio:
      return DSStrings.digioCash
    case .products:
      return DSStrings.products
    default: return String()
    }
  }
}
