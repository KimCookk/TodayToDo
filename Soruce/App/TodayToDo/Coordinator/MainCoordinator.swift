import Foundation
import UIKit

protocol MainCoordinatorDelegate{
    func didShowAddView(_ coordinator: Coordinator)
    func didShowEditView(_ coordinator: Coordinator, doID: String)

}

class MainCoordinator: Coordinator{
    var delegate: MainCoordinatorDelegate?
    var childCoordinator: [Coordinator] = []
    
    private var navigationController: UINavigationController!

    private var mainViewController: PreMainViewController
//    let mainViewController: MainViewController = {
//        
//        let viewModel = DoTableViewModel(realmUseCase: usecase)
//
//        return MainViewController(doTableViewModel: viewModel)
//    }()
    
    func start() {
        mainViewController.delegate = self
        self.navigationController.viewControllers = [mainViewController]
    }
    
    init(navigationController: UINavigationController, realmUseCase: RealmUseCase){
        self.navigationController = navigationController
        self.mainViewController = PreMainViewController(doTableViewModel: DoTableViewModel(realmUseCase: realmUseCase))
    }
}

extension MainCoordinator: MainViewControllerDelegate{
    func showEditView(doID: String) {
        delegate?.didShowEditView(self, doID: doID)
    }
    func showAddView() {
        delegate?.didShowAddView(self)
    }
}
