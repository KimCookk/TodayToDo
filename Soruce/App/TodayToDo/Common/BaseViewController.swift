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
    @objc optional func setupBindgs()
}

class BaseViewController: UIViewController , BaseViewControllerCustomizable {
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        _setupViews()
        _setupBinds()
    }
    
    func _setupViews() {
        view.backgroundColor = .darkGray
        (self as BaseViewControllerCustomizable).setupViews?()
    }
    func _setupBinds() {
        (self as BaseViewControllerCustomizable).setupBindgs?()
    }
}
