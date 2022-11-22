//
//  TabView.swift
//  TodayToDo
//
//  Created by 김태성 on 2022/09/24.
//

import Foundation
import UIKit

class TabView: BaseView{
    // MARK Properties
    //
    
    // MARK UI Component
    //
    let cotainer: UIStackView = {
        let view = HStackView()
        view.chain
            .spacing(20)
            .distribution(.fill)
            .layoutMargins(NSDirectionalEdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
        
        return view
    }()
    
    let addDoButton: UIButton = {
        let button = UIButton()
        button.chain
            .background(color: DesignService.purple2)
            .cornerRadius(43, radiusOpts: .all)
            .setImage(UIImage(systemName: "plus")?.withTintColor(.white , renderingMode: .alwaysOriginal))
            .setSizeImage(size: 30)
        
        return button
    }()
    
    let alarmButton: UIButton = {
        let button = UIButton()
        button.chain
            .background(color: DesignService.purple2)
            .cornerRadius(43, radiusOpts: .all)
            .setImage(UIImage(systemName: "alarm")?.withTintColor(.white , renderingMode: .alwaysOriginal))
            .setSizeImage(size: 30)
        
        return button
    }()
    
    override func configureView() {
        cotainer.chain
            .add(to: self)
            .edgeTo(self, isSetSafeArea: false)
        
        DesignService.paintSpacer().chain
            .add(to: cotainer)
        
        addDoButton.chain
            .add(to: cotainer)
            .constraint{ (make) in
                make.width.equalTo(85)
            }
        
        alarmButton.chain
            .add(to: cotainer)
            .constraint{ (make) in
                make.width.equalTo(85)
            }
    }
    
    override func configureLayer() {
        addDoButton.chain
            .paintShadow()
        
        alarmButton.chain
            .paintShadow()
    }
    
    func setOption(isOnAdd: Bool = true, isOnAlarm: Bool = true){
        
        if(!isOnAdd){
            addDoButton.isEnabled = false
            //addDoButton.setImage(nil, for: .normal)
            addDoButton.backgroundColor = .clear
            addDoButton.layer.isHidden = true
        }
        if(!isOnAlarm){
            alarmButton.isEnabled = false
            //alarmButton.setImage(nil, for: .normal)
            alarmButton.backgroundColor = .clear
            alarmButton.layer.isHidden = true
        }
    }
}
