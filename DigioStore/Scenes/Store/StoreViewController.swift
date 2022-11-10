import UIKit

// MARK: - StoreViewController

class StoreViewController: BaseViewController<StoreView> {
  
  // MARK: - Override methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    testRequest()
  }
}

// MARK: - Internal methods

extension StoreViewController {
  
  func testRequest() {
    let service = StoreService()
    
    service.fetchStore { result in
      switch result {
      case .success(let response):
        print(response)
      case .failure(let error):
        print(error)
      }
    }
  }
}
