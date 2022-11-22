//
//  BaseViewController.swift
//  TodayToDo
//
//  Created by 김태성 on 2022/09/04.
//

import UIKit
import RxCocoa
import RxSwift

@objc protocol BaseViewControllerCustomizable{
    @objc optional func setupViews()
    @objc optional func setupBinds()
    @objc optional func setupLayer()
}

class PreBaseViewController: UIViewController , BaseViewControllerCustomizable {
    var disposeBag = DisposeBag()
    
    lazy var containerView: UIStackView = {
        let stack = VStackView()
        stack.chain
            .distribution(.fill)
        return stack
    }()
    lazy var navigationView = PreNavigationView()
    
    lazy var tabView = PreTabView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseSetupViews()
        baseSetupBinds()
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    override func viewDidAppear(_ animated: Bool) {
        baseSetupLayer()
    }
    
    func baseSetupViews() {
        view.backgroundColor = DesignService.purple1
        
        containerView.chain
            .add(to: view)
            .edgeTo(view, isSetSafeArea: true)
        
        navigationView.chain
            .add(to: containerView)
            .constraint{ (make) in
                make.height.equalTo(110)
                make.width.equalToSuperview()
            }
            .origin.paintView()
        
        tabView.chain
            .add(to: containerView)
            .constraint{ (make) in
                make.height.equalTo(100)
                make.width.equalToSuperview()
            }
            .origin.paintView()
        (self as BaseViewControllerCustomizable).setupViews?()
    }
    func baseSetupBinds() {
        tabView.addDoButton.addTarget(self, action: #selector(showTestView), for: .touchDown)
        //tabView.alarmButton.addTarget(self, action: #selector(popTestView), for: .touchDown)
        navigationView.navigationBar.leftButton.addTarget(self, action: #selector(dismissTestView), for: .touchDown)
        
        (self as BaseViewControllerCustomizable).setupBinds?()
    }
    func baseSetupLayer()
    {
        containerView.chain.backgroundGradient(startColor: DesignService.getColorHex(hex: 0xcac9e9), endColor: DesignService.getColorHex(hex: 0x9395D3))
        
        tabView.paintShadow()
        (self as BaseViewControllerCustomizable).setupLayer?()
    }
    
    @objc func showTestView() {
        //let testViewController = EditDoviewController()
        //testViewController.modalPresentationStyle = .fullScreen
        //present(testViewController, animated: false, completion: nil)
    }
    
    @objc func dismissTestView() {
        self.dismiss(animated: false)
    }
}
