//
//  DoAddViewModel.swift
//  TodayToDo
//
//  Created by 김태성 on 2022/11/08.
//

import Foundation
import RxSwift

class DoAddViewModel{
    // MARK: Properteis
    private let disposeBag = DisposeBag()
    private var realmUseCase: RealmUseCase
    // MARK: Properties - Input
    let selectedDayType: AnyObserver<String>
    let inputTitle: AnyObserver<String>
    let inputContent: AnyObserver<String>
    let addDoEvent: AnyObserver<Bool>
    
    var title = ""
    var content = ""
    var cycle = ""
    // MARK: Properties - Output
    var checkedInput = false

    
    init(realmUseCase: RealmUseCase){
        self.realmUseCase = realmUseCase
        
        let dayType = BehaviorSubject<String>(value: "Daily")
        let title = BehaviorSubject<String>(value: "")
        let content = BehaviorSubject<String>(value: "")
        let addDo = BehaviorSubject<Bool>(value: false)
        
        selectedDayType = dayType.asObserver()
        inputTitle = title.asObserver()
        inputContent = content.asObserver()
        addDoEvent = addDo.asObserver()
        
        
        Observable.combineLatest(dayType,title,content)
            .subscribe(onNext: { dayType, title, content in
                self.title = title
                self.content = content
                self.cycle = dayType
                self.checkedInputs(dayType: dayType, title: title)
            }).disposed(by: disposeBag)
        
        addDo
            .subscribe(onNext: { event in
                if(event){
                    self.tappedAddButton()
                }
            }).disposed(by: disposeBag)
    }
    
    private func checkedInputs(dayType: String, title: String){
        if(!dayType.isEmpty && !title.isEmpty){
            checkedInput = true
        } else {
            checkedInput = false
        }
        print("checkedInputs checkedInput: \(checkedInput)")
    }
    
    private func tappedAddButton(){
        realmUseCase.create(title: self.title, content: self.content, cycle: self.cycle)
    }
}
