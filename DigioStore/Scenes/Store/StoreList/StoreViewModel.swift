import UIKit

// MARK: - StoreDelegate

protocol StoreDelegate: class {
  func updateTableView()
  func showEmptyDataMessage()
  func showErrorMessage(error: String)
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
          self?.handleData(data: response)
        }
      case .failure(let error):
        DispatchQueue.main.async {
          self?.delegate?.showErrorMessage(error: error.message)
        }
      }
    }
  }
  
  func routeToDetails(selectedItem: Item) {
    coordinator.routeToDetails(item: selectedItem)
  }
}

// MARK: - Private methods

private extension StoreViewModel {
  
  func handleData(data: Store) {
    var storeItems: [Item] = []
    
    if let data = data.spotlight {
      data.forEach { item in
        let item = Item(title: item.name,
                        imageURL: item.bannerURL,
                        description: item.description)
        storeItems.append(item)
      }
      let section = StoreSection(key: .spotlight, value: storeItems)
     storeSections.append(section)
    }

    if let data = data.cash {
      storeItems = []
    let item = Item(title: data.title,
                    imageURL: data.bannerURL,
                    description: data.description)
      storeItems.append(item)
      let section = StoreSection(key: .cashDigio, value: storeItems)
      storeSections.append(section)
    }
    
    if let data = data.products {
      storeItems = []
      data.forEach { item in
        let item = Item(title: item.name,
                        imageURL: item.imageURL,
                        description: item.description)
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
