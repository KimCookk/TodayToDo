//
//  SceneDelegate.swift
//  TodayToDo
//
//  Created by 김태성 on 2022/09/04.
//

import UIKit

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: scene)
        self.window = window
        
        let navigationController = UINavigationController()
        self.window?.rootViewController = navigationController
        
        let coordinator = AppCoordinator(navigationCotnroller: navigationController)
        coordinator.start()
        
        window.makeKeyAndVisible()
        
    }
}
