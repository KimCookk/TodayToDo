//
//  AddDoViewController+UI.swift
//  TodayToDo
//
//  Created by 김태성 on 2022/09/17.
//

import UIKit

extension PreAddDoViewController{
    func setupViews() {
        print("AddDoViewController setupViews")
        
        super.navigationView.setOption(isOnRightButton: false, isOnMenuBar: false)
        super.navigationView.setTitle(title: "ADD TODO!")
        
        super.tabView.setOption(isOnAdd: false, isOnAlarm: false)
        
        doAddView.chain
            .add(to: super.containerView, at: 1)
            .origin.paintView()

    }
    
    func setupLayer(){
        print("AddDoViewController setUpLayer")
        doAddView.paintShadow()

    }
}
