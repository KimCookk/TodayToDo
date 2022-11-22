//
//  PopUpView.swift
//  TodayToDo
//
//  Created by 김태성 on 2022/10/09.
//

import Foundation
import UIKit
import RxSwift

class PopUpView: BaseView {
    // MARK : Properties
    let disposeBag = DisposeBag()
    let selectYesOrNo = PublishSubject<Bool>()
    
    // MARK : UI Component
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.chain
            .background(color: .gray, alpha: 0.5)
        return view
    }()
    
    lazy var popUpView: UIView = {
        let view = UIView()
        view.chain
            .background(color: DesignService.purple3)
            .cornerRadius(25, radiusOpts: .all)
            
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.chain
            .font(font: DesignService.header2, color: DesignService.white)
            .textAligment(align: .center)
        
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        label.chain
            .font(font: DesignService.header3, color: DesignService.white)
            .sizeToFit()
            .close()
        
        return label
    }()
    
    lazy var okButton: UIButton = {
        let button = UIButton()
        button.chain
            .title("Ok")
            .background(color: DesignService.purple2)
            .cornerRadius(15, radiusOpts: .all)
            .close()
        
        return button
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.chain
            .title("Close")
            .background(color: DesignService.purple2)
            .cornerRadius(15, radiusOpts: .all)
            .close()
        
        return button
    }()
    
    override func configureView(){
        self.frame = UIScreen.main.bounds
        
        backgroundView.chain
            .add(to: self)
            .constraint{ make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
                make.width.equalToSuperview()
                make.height.equalToSuperview()
            }
        
        popUpView.chain
            .add(to: backgroundView)
            .constraint{ make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
                make.width.equalToSuperview().multipliedBy(0.7)
                make.height.equalToSuperview().multipliedBy(0.3)
            }
        
        titleLabel.chain
            .add(to: popUpView)
            .constraint{ make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().multipliedBy(0.5)
                make.width.equalToSuperview().multipliedBy(0.9)
                make.height.equalToSuperview().multipliedBy(0.3)
            }
        
        subTitleLabel.chain
            .add(to: popUpView)
            .constraint{ make in
                make.centerX.equalToSuperview()
                make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
                make.width.equalToSuperview().multipliedBy(0.9)
            }
        
        okButton.chain
            .add(to: popUpView)
            .constraint{ make in
                make.centerX.equalToSuperview().multipliedBy(0.6)
                make.centerY.equalToSuperview().multipliedBy(1.7)
                make.width.equalToSuperview().multipliedBy(0.3)
                make.height.equalToSuperview().multipliedBy(0.1)
            }
        
        closeButton.chain
            .add(to: popUpView)
            .constraint{ make in
                make.centerX.equalToSuperview().multipliedBy(1.4)
                make.centerY.equalToSuperview().multipliedBy(1.7)
                make.width.equalToSuperview().multipliedBy(0.3)
                make.height.equalToSuperview().multipliedBy(0.1)
            }
    }
    
    override func configureEvent() {
        
        okButton.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                print("tap Ok Button")
                self.selectYesOrNo.onNext(true)
                self.removeFromSuperview()
            }).disposed(by: disposeBag)
        
        closeButton.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                print("close Ok Button")
                self.selectYesOrNo.onNext(false)
                self.removeFromSuperview()
            }).disposed(by: disposeBag)
    }
    
    @discardableResult
    func initView(title: String, subTitle: String) -> PopUpView{
        
        titleLabel.chain
            .text(title)
            .close()
        
        subTitleLabel.chain
            .text(subTitle)
            .close()
        
        return self
    }
    
    @discardableResult
    func showPopUp(parent: UIView) -> Observable<Bool>{
        self.chain.add(to: parent)
        
        return selectYesOrNo.asObservable()
    }
}
