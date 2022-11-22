import Foundation
import UIKit

class AppCoordinator: Coordinator{
    var childCoordinator: [Coordinator] = []
    
    private var navigationController: UINavigationController!
    private let realmUsecase = RealmUseCase()
    
    func start() {
        showMainViewController()
    }
    
    init(navigationCotnroller: UINavigationController){
        navigationCotnroller.navigationBar.isHidden = true
        self.navigationController = navigationCotnroller
    }
    
    private func showMainViewController(){
        let coordinator = MainCoordinator(navigationController: self.navigationController, realmUseCase: self.realmUsecase)
        coordinator.delegate = self
        coordinator.start()
        self.childCoordinator.append(coordinator)
    }
    
    private func showAddViewController(){
        let coordinator = AddCoordinator(navigationController: self.navigationController, realmUseCase: self.realmUsecase)
        coordinator.delegate = self
        coordinator.start()
        self.childCoordinator.append(coordinator)
    }
    
    private func showEditViewController(doID: String){
        let coordinator = EditCoordinator(navigationController: self.navigationController, realmUseCase: self.realmUsecase, doID: doID)
        coordinator.delegate = self
        coordinator.start()
        self.childCoordinator.append(coordinator)
    }
}

extension AppCoordinator: MainCoordinatorDelegate{
    func didShowEditView(_ coordinator: Coordinator, doID: String) {
        self.childCoordinator = self.childCoordinator.filter{ $0 !== coordinator }
        self.showEditViewController(doID: doID)
        
    }
    
    func didShowAddView(_ coordinator: Coordinator) {
        self.childCoordinator = self.childCoordinator.filter{ $0 !== coordinator }
        self.showAddViewController()
    }
}

extension AppCoordinator: AddCoordinatorDelegate{
    func addToMainView(_ coordinator: Coordinator) {
        self.childCoordinator = self.childCoordinator.filter{ $0 !== coordinator }
        self.showMainViewController()
    }
}

extension AppCoordinator: EditCoordinatorDelegate{
    func editToMainView(_ coordinator: Coordinator) {
        self.childCoordinator = self.childCoordinator.filter{ $0 !== coordinator }
        self.showMainViewController()
    }
}
