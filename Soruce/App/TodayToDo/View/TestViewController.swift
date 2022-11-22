//
//  TestViewController.swift
//  TodayToDo
//
//  Created by 김태성 on 2022/09/14.
//

import UIKit

class TestViewController: PreBaseViewController {
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.backgroundColor = .gray
        return button
    }()
    
    func setupViews() {
        print("TestViewController setupViews")
        view.backgroundColor = .systemMint
        view.chain
            .add(children: button)
        
        button.chain
            .constraint{
                (make) in
                make.centerX.centerY.equalToSuperview()
                make.width.height.equalTo(100)
            }
        
    }
    
    func setupBinds() {
        print("TestViewController setupBinds")
        button.addTarget(self, action: #selector(unShowTestView), for: .touchUpInside)
    }
    @objc func unShowTestView() {
        self.dismiss(animated: false
        )
    }
}
