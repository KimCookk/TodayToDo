//
//  DoTableVeiw.swift
//  TodayToDo
//
//  Created by 김태성 on 2022/09/24.
//

import UIKit

class DoTableView: BaseScrollView{
    
    var doItemViews: [DoItemView] = []
    
    let tableView: UIStackView = {
        let view = VStackView()
        view.chain
            .spacing(15)
            .distribution(.fill)
            .layoutMargins(NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        
        return view
    }()

    override func configureView() {
        tableView.chain
            .add(to: self)
            .edgeTo(self, isSetSafeArea: false)
            .constraint{ (make) in
                make.width.equalToSuperview()
                make.top.equalTo(self.contentLayoutGuide.snp.top)
                make.leading.equalTo(self.contentLayoutGuide.snp.leading)
            }
        
        doItemViews.forEach { (view) in
            view.chain
                .add(to: tableView)
        }
        
        DesignService.paintSpacer().chain
            .add(to: tableView)
    }
    
    override func configureLayer() {
        doItemViews.forEach{ (view) in
            view.chain
                .paintShadow()
        }
    }
}

extension DoTableView{
    func reloadData(viewModelItems: [ViewDoItem]){
        tableView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        doItemViews.removeAll()
        viewModelItems.forEach{ item in
            let doItemView = DoItemView()
            doItemView.configureView(item: item)
            doItemView.chain.add(to: tableView)
            doItemViews.append(doItemView)
        }
        DesignService.paintSpacer().chain
            .add(to: tableView)
        
        //configureLayer()
    }
}


    
