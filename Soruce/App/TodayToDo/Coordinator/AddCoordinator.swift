import Foundation
import UIKit

protocol AddCoordinatorDelegate{
    func addToMainView(_ coordinator: Coordinator)
}

class AddCoordinator: Coordinator{
    var delegate: AddCoordinatorDelegate?
    var childCoordinator: [Coordinator] = []
    
    private var navigationController: UINavigationController!

    let addViewController: DoAddViewController
    
    func start() {
        addViewController.delegate = self
        self.navigationController.viewControllers = [addViewController]
    }
    
    init(navigationController: UINavigationController, realmUseCase: RealmUseCase){
        self.navigationController = navigationController
        self.addViewController = DoAddViewController(doAddViewModel: DoAddViewModel(realmUseCase: realmUseCase))
    }
}

extension AddCoordinator: DoAddViewControllerDelegate{
    func backMainView() {
        delegate?.addToMainView(self)
    }
}
