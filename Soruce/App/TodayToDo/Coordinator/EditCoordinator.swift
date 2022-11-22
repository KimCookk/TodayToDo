import Foundation
import UIKit

protocol EditCoordinatorDelegate{
    func editToMainView(_ coordinator: Coordinator)
}

class EditCoordinator: Coordinator{
    var delegate: EditCoordinatorDelegate?
    var childCoordinator: [Coordinator] = []
    
    private var navigationController: UINavigationController!

    let editViewController: DoEditViewController
    
    func start() {
        editViewController.delegate = self
        self.navigationController.viewControllers = [editViewController]
    }
    
    init(navigationController: UINavigationController, realmUseCase: RealmUseCase, doID: String){
        self.navigationController = navigationController
        self.editViewController = DoEditViewController(doEditViewModel: DoEditViewModel(realmUseCase: realmUseCase, doID: doID))
    }
}

extension EditCoordinator: DoEditViewControllerDelegate{
    func backMainView() {
        delegate?.editToMainView(self)
    }
}
