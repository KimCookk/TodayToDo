import Foundation
import RxSwift
import RxRelay

class DoEditViewModel{
    // MARK: Properties
    private let disposeBag = DisposeBag()
    private var realmUseCase: RealmUseCase
    
    private var inputDayType: String = ""
    private var inputTitle: String = ""
    private var inputContent: String = ""
    
    
    // MARK: Properties - Input
    let dayTypeObserver: AnyObserver<String?>
    let titleObserver: AnyObserver<String?>
    let contentObserver: AnyObserver<String?>
    let editDoEventObserver: AnyObserver<Bool>
    
    // MARK: Properties - Output
    let editDoItem: BehaviorRelay<ViewDoItem?>
    
    init(realmUseCase: RealmUseCase, doID: String){
        self.realmUseCase = realmUseCase
        
        let dayType = BehaviorSubject<String?>(value: nil)
        let title = BehaviorSubject<String?>(value: nil)
        let content = BehaviorSubject<String?>(value: nil)
        let editDo = BehaviorSubject<Bool>(value: false)
        
        dayTypeObserver = dayType.asObserver()
        titleObserver = title.asObserver()
        contentObserver = content.asObserver()
        editDoEventObserver = editDo.asObserver()
        
        editDoItem = BehaviorRelay<ViewDoItem?>(value: nil)
       
        realmUseCase.read(filterStr: doID, filterType: .doID)
            .subscribe(onNext: { doItems in
                if(!doItems.isEmpty){
                    let doItem = doItems[0]
                    self.editDoItem.accept(ViewDoItem(doItem: doItem))
                    self.inputDayType = doItem.dayCycle
                    self.inputTitle = doItem.doTitle
                    self.inputContent = doItem.doSubTitle
                }
            })
            .disposed(by: disposeBag)
        
        dayType
            .subscribe(onNext: { inputDayType in
                guard let inputDayType = inputDayType else { return }
                self.inputDayType = inputDayType
            })
            .disposed(by: disposeBag)
        
        title
            .subscribe(onNext: { inputTitle in
                guard let inputTitle = inputTitle else { return }
                self.inputTitle = inputTitle
            })
            .disposed(by: disposeBag)
        
        content
            .subscribe(onNext: { inputContent in
                guard let inputContent = inputContent else { return }
                self.inputContent = inputContent
            })
            .disposed(by: disposeBag)
        
        editDo
            .skip(1)
            .subscribe(onNext: { event in
                let doItem = self.editDoItem.value
                print("Click Edit Do!")
                guard let doItem = doItem else {
                    return
                }

                guard let doID = doItem.doID else { return }

                self.updateDoItem(id: doID, doTitle: self.inputTitle, doSubTitle: self.inputContent, dayCycle: self.inputDayType)
                
            })
            .disposed(by: disposeBag)
    }
    
    private func updateDoItem(id: String, doTitle: String, doSubTitle: String, dayCycle: String){
        print("updateDoItem!")
        print("\(id) \(doTitle) \(doSubTitle) \(dayCycle)")
        realmUseCase.update(id: id, doTitle: doTitle, doSubTitle: doSubTitle, dayCycle: dayCycle)
    }
}
