//
//  BaseView.swift
//  TodayToDo
//
//  Created by 김태성 on 2022/09/14.
//

import UIKit

protocol PreBaseView{
    func paintView()
}

class BaseView: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureEvent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(){
       // self.backgroundColor = .systemBackground
    }
    
    func configureEvent(){
        
    }
    
    func configureLayer(){
        
    }
}

class BaseDoItemView: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(item: ViewDoItem? = nil){
        //self.backgroundColor = .systemBackground
    }
    
    func configureLayer(){
        
    }
}

class BaseScrollView: UIScrollView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(){
        self.showsVerticalScrollIndicator = true
    }
    
    func configureLayer(){
        
    }
}
