//
//  NavigationView.swift
//  TodayToDo
//
//  Created by 김태성 on 2022/09/24.
//

import UIKit

class NavigationView: BaseView{
    
    // MARK Properties
    var isMenu: Bool = true
    var isLeftButton: Bool = true
    var isRightButton: Bool = true
    var title: String = ""
    //
    
    // MARK UI Components
    let container: UIStackView = {
       let stack = VStackView()
        stack.chain
            .background(color: DesignService.purple1)
            .spacing(5)
            .distribution(.fill)
            .cornerRadius(30, radiusOpts: DesignService.CornerRadiusType.bottomLeft, DesignService.CornerRadiusType.bottomRight)
        return stack
    }()
    
    let naviHStack: UIStackView = {
        let stack = HStackView()
        stack.chain
            .spacing(5)
            .distribution(.fill)
        return stack
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.chain
            .font(font: DesignService.header1, color: DesignService.white)
            .textAligment(align: .center)
        return label
    }()
    
    let leftButton: UIButton = {
        let button = UIButton()
        button.chain
            .setImage(UIImage(systemName: "chevron.backward")?.withTintColor(.white , renderingMode: .alwaysOriginal))
            .setSizeImage(size: 25)
        return button
    }()
    
    let rightButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    let menuHStack: UIStackView = {
        let stack = HStackView()
        stack.chain
            .spacing(5)
            .distribution(.fillEqually)
            .layoutMargins(NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        return stack
    }()
    
    lazy var menuButtons: [DesignService.MenuBarButtonType: UIButton] = {
        var bars = [DesignService.MenuBarButtonType: UIButton]()
        DesignService.MenuBarButtonType.allCases.forEach{ (dayType) in
            let button = UIButton()
            button.chain
                .title("\(dayType)")
                .font(font: DesignService.header3, color: DesignService.gray1)
            bars[dayType] = button
        }
        return bars
    }()
    
    override func configureView() {
        container.chain
            .add(to: self)
            .edgeTo(self, isSetSafeArea: false)
        
        naviHStack.chain
            .add(to: container)
            .constraint{ make in
                make.height.equalTo(60)
            }
        
        leftButton.chain
            .add(to: naviHStack)
            .constraint{ (make) in
                make.width.equalTo(50)
            }
        
        titleLabel.chain
            .add(to: naviHStack)
            .text(text: DesignService.commonNaviTitle)
        
        rightButton.chain
            .add(to: naviHStack)
            .constraint{ (make) in
                make.width.equalTo(50)
            }
        
        menuHStack.chain
            .add(to: container)
            .constraint{ make in
                //make.height.equalTo(50)
            }
        
        menuButtons[menuButtons.keys.sorted()[0]]?.chain
            .font(font: DesignService.header3, color: DesignService.white)

            
        menuButtons.keys.sorted().forEach{
            menuButtons[$0]?.chain
                .add(to: menuHStack)
        }
    }
    
    override func configureLayer() {

    }
    
    func setOption(naviTitle: String = DesignService.commonNaviTitle, isOnLeftButton: Bool = true, isOnRightButton: Bool = true, isOnTitle: Bool = true, isOnMenuBar: Bool = true){
        titleLabel.chain
            .text(naviTitle)
        
        if(!isOnLeftButton || !isOnRightButton || !isOnTitle)
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
            if(!isOnTitle)
            {
                titleLabel.textColor = .clear
            }
        }
    
        if(!isOnMenuBar)
        {
                menuButtons.forEach{ (menu) in
                    menu.value.isEnabled = false
                    menu.value.tintColor = .clear
                    menu.value.setTitleColor(.clear, for: .normal)
                }
        }
    }
    
    func changeMenu(type: DesignService.MenuBarButtonType){
        print("\(self) \(#function)")
        
        menuButtons.values.forEach{ button in
            button.chain
                .font(font: DesignService.header3, color: DesignService.gray1)
        }

        let selectMenu = menuButtons[type]
        selectMenu?.chain
            .font(font: DesignService.header3, color: DesignService.white)
            

    }
    
    
}
