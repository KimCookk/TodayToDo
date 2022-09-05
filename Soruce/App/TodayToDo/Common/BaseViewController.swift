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
}

class BaseViewController: UIViewController , BaseViewControllerCustomizable {
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        _setupViews()
        _setupBinds()
    }
    
    func _setupViews() {
        (self as BaseViewControllerCustomizable).setupViews?()
    }
    func _setupBinds() {
        (self as BaseViewControllerCustomizable).setupBinds?()
    }
}
