import UIKit

// MARK: - StoreViewController

class StoreViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.red
    testRequest()
  }
  
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
