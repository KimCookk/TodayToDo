//
//  NavigationView.swift
//  TodayToDo
//
//  Created by 김태성 on 2022/09/14.
//

import UIKit
    
class PreNavigationView: UIView, PreBaseView{
    
    var isOnTitle: Bool = true
    var isOnLeftButton: Bool = true
    var isOnRightButton: Bool = true
    var isOnMenu: Bool = true
    
    
    lazy var mainVStack: UIStackView = {
        let stack = VStackView()
        stack.chain
            .background(color: DesignService.purple1)
            .spacing(5)
            .distribution(.fill)
        return stack
    }()
    
    lazy var navigationBar = NavigationBarView()
    
    lazy var menuBar = MenuBarView()
    
    func paintView(){
        self.chain.cornerRadius(30, radiusOpts: DesignService.CornerRadiusType.bottomLeft, DesignService.CornerRadiusType.bottomRight)
        
        mainVStack.chain
            .add(to: self)
            .edgeTo(self, isSetSafeArea: false)
            .background(color: DesignService.purple1)
        
        navigationBar.chain
            .add(to: mainVStack)
            .constraint{ (make) in
                make.height.equalTo(60)
            }.origin.paintView()
        
        menuBar.chain
            .add(to: mainVStack)
            .constraint{ (make) in
                make.height.equalTo(50)
            }.origin.paintView()
    }
    
    func setTitle(title: String){
        navigationBar.titleLabel.text = title
    }
    
    func setOption(isOnLeftButton: Bool = true, isOnRightButton: Bool = true, isOnTitle: Bool = true, isOnMenuBar: Bool = true){
        if(!isOnLeftButton || !isOnRightButton || !isOnTitle)
        {
            navigationBar.setOption(isOnLeftButton: isOnLeftButton, isOnRightButton: isOnRightButton, isOnTilte: isOnTitle)
        }
    
        if(!isOnMenuBar)
        {
            menuBar.setOption(isOnMenu: isOnMenuBar)
        }
    }
}
class NavigationBarView: UIView, PreBaseView{
   
    lazy var mainHStack: UIStackView = {
        let stack = HStackView()
        stack.chain
            .spacing(5)
            .distribution(.fill)
        return stack
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.chain
            .font(font: DesignService.header1, color: DesignService.white)
            .textAligment(align: .center)
        return titleLabel
    }()
    
    lazy var leftButton: UIButton = {
        let button = UIButton()
        button.chain
            .setImage(UIImage(systemName: "chevron.backward")?.withTintColor(.white , renderingMode: .alwaysOriginal))
            .setSizeImage(size: 25)
        return button
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    
    func paintView(){
        mainHStack.chain
            .add(to: self)
            .edgeTo(self, isSetSafeArea: false)
        
        leftButton.chain
            .add(to: mainHStack)
            .constraint{ (make) in
                make.width.equalTo(50)
            }
        
        titleLabel.chain
            .add(to: mainHStack)
            .text(text: DesignService.commonNaviTitle)
        
        rightButton.chain
            .add(to: mainHStack)
            .constraint{ (make) in
                make.width.equalTo(50)
            }
    }
    
    func setOption(isOnLeftButton: Bool, isOnRightButton: Bool, isOnTilte: Bool)
    {
        if(!isOnLeftButton)
        {
            leftButton.isEnabled = false
            leftButton.setImage(nil, for: .normal)
        }
        if(!isOnRightButton)
        {
            rightButton.isEnabled = false
            rightButton.setImage(nil, for: .normal)
        }
        if(!isOnTilte)
        {
            titleLabel.textColor = .clear
        }
    }
}

class MenuBarView: UIView, PreBaseView{
    lazy var mainStack: UIStackView = {
        let stack = HStackView()
        stack.chain
            .spacing(5)
            .distribution(.fillEqually)
            .layoutMargins(NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        return stack
    }()
    
    lazy var menuBars: [String: UIButton] = {
        var bars = [String: UIButton]()
//        DesignService.MenuBarButtonTypes.forEach{ (dayType) in
//            let button = UIButton()
//            button.chain
//                .title(dayType)
//                .font(font: DesignService.header3, color: DesignService.white)
//            bars[dayType] = button
//        }
        return bars
    }()
    
    func paintView(){
        
        mainStack.chain
            .add(to: self)
            .edgeTo(self, isSetSafeArea: false)
        
//        DesignService.MenuBarButtonTypes.forEach{ (dayType) in
//            menuBars[dayType]?.chain
//                .add(to: mainStack)
//        }
    }
    
    func setOption(isOnMenu: Bool)
    {
        if(!isOnMenu){
            menuBars.forEach{ (menu) in
                menu.value.isEnabled = false
                menu.value.tintColor = .clear
                menu.value.setTitleColor(.clear, for: .normal)
            }
        }
    }
}
