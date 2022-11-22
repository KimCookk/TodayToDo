import Foundation

protocol Coordinator : class {
    var childCoordinator : [Coordinator] {get set}
    func start()
}
