//
//  EditDoViewController+UI.swift
//  TodayToDo
//
//  Created by 김태성 on 2022/09/19.
//

import UIKit

extension EditDoviewController{
    func setupViews() {
        print("EditDoviewController setupViews")
        
        super.navigationView.setOption(isOnRightButton: false, isOnMenuBar: false)
        super.navigationView.setTitle(title: "Edit TODO!")
        
        super.tabView.setOption(isOnAdd: false, isOnAlarm: false)
        
        doAddView.chain
            .add(to: super.containerView, at: 1)
            .origin.paintView()
    }
    
    func setupLayer(){
        print("EditDoviewController setUpLayer")
        doAddView.paintShadow()
    }
}

