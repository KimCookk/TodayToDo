//
//  DoTableView.swift
//  TodayToDo
//
//  Created by 김태성 on 2022/09/14.
//

import UIKit

class PreDoTableView: UIScrollView, PreBaseView{
    
    var items = [PreDoItemView(), PreDoItemView(), PreDoItemView()]
    
    lazy var tableView: UIStackView = {
        let view = VStackView()
        view.chain
            .spacing(10)
            .distribution(.fill)
            .layoutMargins(NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        
        return view
    }()
    
    func paintView() {
        tableView.chain
            .add(to: self)
            .edgeTo(self, isSetSafeArea: false)
            .constraint{ (make) in
                make.width.equalToSuperview()
                make.top.equalTo(self.contentLayoutGuide.snp.top)
                make.leading.equalTo(self.contentLayoutGuide.snp.leading)
            }
        
        items.forEach { (item) in
            item.chain
                .add(to: tableView)
                .origin.paintView()
        }
        
        DesignService.paintSpacer().chain
            .add(to: tableView)
    }
    
    func paintShadow() {
        items.forEach{ (itemView) in
            itemView.chain.paintShadow()
        }
    }
}

class PreDoItemView: UIView, PreBaseView{
    
    lazy var containerView: UIStackView = {
        let view = HStackView()
        view.chain
            .distribution(.fill)
        
        return view
    }()
    
    lazy var itemView: UIStackView = {
        let view = VStackView()
        view.chain
            .distribution(.fillEqually)
            .layoutMargins(NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        
        return view
    }()
    
    lazy var functionView: UIStackView = {
        let view = HStackView()
        view.chain
            .distribution(.fillEqually)
        
        return view
    }()
    
    lazy var itemTitleLabel: UILabel = {
        let label = UILabel()
        label.chain.font(font: DesignService.content1, color: DesignService.white)
        return label
    }()
    
    lazy var itemContentLabel: UILabel = {
        let label = UILabel()
        label.chain.font(font: DesignService.content2, color: DesignService.gray2)
        return label
    }()
    
    lazy var typeLabel: UIButton = {
        let label = UIButton()
        label.chain
            .setImage(UIImage(systemName: "d.circle")?.withTintColor(.white , renderingMode: .alwaysOriginal))
        return label
    }()
    
    lazy var checkButton: UIButton = {
        let button = UIButton()
        button.chain
            .setImage(UIImage(systemName: "square")?.withTintColor(.white , renderingMode: .alwaysOriginal))
        return button
    }()
    
    lazy var editButton: UIButton = {
        let button = UIButton()
        button.chain.setImage(UIImage(systemName: "square.and.pencil")?.withTintColor(.white , renderingMode: .alwaysOriginal))
        return button
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.chain
            .setImage(UIImage(systemName: "trash")?.withTintColor(.white , renderingMode: .alwaysOriginal))
        return button
    }()
    
    func paintView() {
        self.chain
            .background(color: DesignService.purple2)
            .cornerRadius(15, radiusOpts: .all)
            .constraint{ (make) in
                make.height.equalTo(80)
            }
        
        containerView.chain
            .add(to: self)
            .edgeTo(self, isSetSafeArea: false)
        
        itemView.chain
            .add(to: containerView)
            .constraint{ (make) in
                make.width.equalTo(220)
            }
        
        functionView.chain
            .add(to: containerView)
                
        itemTitleLabel.chain
            .add(to: itemView)
            .text(attributeText: DesignService.combineImageAndText(systemName: "d.circle.fill", text: "Title 입니다."))
            .constraint{ (make) in
                make.width.equalToSuperview()
                make.height.equalTo(30)
            }
        
        itemContentLabel.chain
            .add(to: itemView)
            .text(text: "Content 입니다.")
            .constraint{ (make) in
                make.width.equalToSuperview()
                make.height.equalTo(30)
            }
        
//        typeLabel.chain
//            .add(to: functionView)
//        
        checkButton.chain
            .add(to: functionView)
        
        editButton.chain
            .add(to: functionView)
        
        deleteButton.chain
            .add(to: functionView)
    }
}
