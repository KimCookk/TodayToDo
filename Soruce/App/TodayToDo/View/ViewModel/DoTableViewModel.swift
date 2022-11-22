//
//  DoListViewModel.swift
//  TodayToDo
//
//  Created by 김태성 on 2022/09/25.
//

import Foundation
import RxSwift
import RxRelay

//protocol MenuViewModelType {
//    var fetchMenus: AnyObserver<Void> { get }
//    var clearSelections: AnyObserver<Void> { get }
//    var makeOrder: AnyObserver<Void> { get }
//    var increaseMenuCount: AnyObserver<(menu: ViewMenu, inc: Int)> { get }
//
//    var activated: Observable<Bool> { get }
//    var errorMessage: Observable<NSError> { get }
//    var allMenus: Observable<[ViewMenu]> { get }
//    var totalSelectedCountText: Observable<String> { get }
//    var totalPriceText: Observable<String> { get }
//    var showOrderPage: Observable<[ViewMenu]> { get }
//}

class DoTableViewModel{
    
    // MARK: Properties
    let doItems = BehaviorRelay<[ViewDoItem]>(value: [])
    //let selectedDoItem = BehaviorRelay<DoItemViewModel?>(value: nil)
    
    private var realmUseCase: RealmUseCase
    
    let disposeBag = DisposeBag()
    
    var filterString = ""
    var filterType = RealmUseCase.FilterType.none
    
    init(realmUseCase: RealmUseCase){
        self.realmUseCase = realmUseCase
    }
    
    func loadAll(){
        
    }
    func load(filterString: String, filterType: RealmUseCase.FilterType){
        print("\(self) \(#function) / filterString : \(filterString) / filterType : \(filterType)")
        self.filterString = filterString
        self.filterType = filterType
        
        realmUseCase.read(filterStr: filterString, filterType: filterType).subscribe(onNext: { items in
            let viewModelItems = items.map{ ViewDoItem(doItem: $0) }
            self.doItems.accept(viewModelItems)
        }).disposed(by: disposeBag)
    }
    
    func delete(id: String){
        realmUseCase.delete(id: id)
        load(filterString: filterString, filterType: filterType)
    }
    
    // 이행 업데이트
    func checkDoItem(id: String){
        realmUseCase.read(filterStr: id, filterType: .doID)
            .subscribe(onNext: { doItems in
                if(!doItems.isEmpty){
                    let doItem = doItems[0]
                    self.realmUseCase.update(id: doItem.doID, isDo: !doItem.isDo)
                }
            }).disposed(by: disposeBag)
        load(filterString: filterString, filterType: filterType)
    }
    
    func add(){
        // realmUseCase.create()
    }
}
