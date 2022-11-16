import UIKit

// MARK: - CoordinatorProtocol

protocol CoordinatorProtocol: AnyObject {
    var children: [CoordinatorProtocol] { get set }
    var navigationController: UINavigationController { get set }
    var parent: CoordinatorProtocol? { get set }
    func start()
}

// MARK: - Coordinator Extensions

extension CoordinatorProtocol {
    func add(_ child: CoordinatorProtocol) {
        children.append(child)
        child.parent = self
    }

    func remove(_ child: CoordinatorProtocol) {
        children.removeAll { $0 === child }
    }
}
