//
//  MainViewController.swift
//  TodayToDo
//
//  Created by 김태성 on 2022/11/22.
//
import UIKit
import Foundation
import RxSwift

protocol MainViewControllerDelegate{
    func showAddView()
    func showEditView(doID: String)
}

class MainViewController: BaseViewController{
    var delegate: MainViewControllerDelegate?
    
    let containerView: UIStackView = {
        let stack = VStackView()
        stack.chain
            .distribution(.fill)
        return stack
    }()
}
