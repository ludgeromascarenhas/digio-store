import UIKit

// MARK: - Class

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  // MARK: - Internal variables
  
  var window: UIWindow?
  
  // MARK: - AppDelegate methods
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    let navigationController = UINavigationController()
    
    let coordinator: StoreCoordinatorProtocol = StoreCoordinator(navigationController: navigationController)
    coordinator.start()
    
    window = UIWindow()
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
    
    return true
  }
}
