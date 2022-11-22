//
//  RealmUseCase.swift
//  TodayToDo
//
//  Created by 김태성 on 2022/09/25.
//

import Foundation
import RealmSwift
import RxSwift

class RealmUseCase{
    
    enum FilterType { case dayCycle, isDo ,none, doID}
    
    let realmDB = try! Realm() // 문법 정리 필요

    init(){
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    // MARK: CRUD
    // Create
    func create(title: String, content: String, cycle: String){
        let doItem = DoItem(doTitle: title, doSubTitle: content, dayCycle: cycle)
        
        try! realmDB.write{
            realmDB.add(doItem)
        }
    }
    // Read
    func read(filterStr: String, filterType: FilterType) -> Observable<[DoItem]>{
        return Observable.create{(observer) -> Disposable in
            self.read(filterStr: filterStr, filterType: filterType, completion: { (error, doitems) in
                if let error = error {
                    observer.onError(error)
                }
                if let doitems = doitems {
                    observer.onNext(doitems)
                }
                observer.onCompleted()
                }
            )
            return Disposables.create()
        }
    }
    
    func delete(id: String){
        let doItem = realmDB.objects(DoItem.self).first(where: { (item) in
            return item.doID == id
        })
        
        guard let doItem = doItem else {
            return
        }

        try! realmDB.write{
            realmDB.delete(doItem)
        }
    }
    
    func update(id: String, doTitle: String? = nil, doSubTitle: String? = nil, dayCycle: String? = nil, isDo: Bool? = nil){
        let doItem = realmDB.objects(DoItem.self).first(where: { (item) in
            return item.doID == id
        })
        
        guard let doItem = doItem else {
            return
        }

        try! realmDB.write{
            do{
                if let doTitle = doTitle {
                    doItem.doTitle = doTitle
                }
                if let doSubTitle = doSubTitle {
                    doItem.doSubTitle = doSubTitle
                }
                if let dayCycle = dayCycle {
                    doItem.dayCycle = dayCycle
                }
                if let isDo = isDo {
                    doItem.isDo = isDo
                }
            }
        }
    }
    
    private func read(filterStr: String, filterType: FilterType, completion: @escaping((Error?, [DoItem]?) -> Void)){
        var results: [DoItem] = []
        do{
            switch(filterType){
            case .dayCycle:
                results = Array(self.realmDB.objects(DoItem.self).sorted(byKeyPath: "isDo", ascending: true).filter{ item in
                    item.dayCycle == filterStr
                })
                break
            case .isDo:
                results = Array(self.realmDB.objects(DoItem.self).sorted(byKeyPath: "isDo", ascending: true).filter{ item in
                    String(item.isDo) == filterStr
                })
                break
            case .doID:
                results = Array(self.realmDB.objects(DoItem.self).sorted(byKeyPath: "isDo", ascending: true).filter{ item in
                    String(item.doID) == filterStr
                })
                break
            case .none:
                results = Array(self.realmDB.objects(DoItem.self).sorted(byKeyPath: "isDo", ascending: true))
            }
            print("results")
            print(results)
        }
        catch {
            print("read Error")
            return completion(error, nil)
        }
        return completion(nil, results)
    }
    
}
