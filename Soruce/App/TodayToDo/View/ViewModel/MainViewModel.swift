import Foundation
import RxSwift
import RxRelay

class MainViewModel{
    // MARK: Properties
    private let disposeBag = DisposeBag()
    private var realmUseCase: RealmUseCase
    
    // MARK: Properties - Input
    // MenuSelect
    let selectMenuObserver: AnyObserver<String>
    //
    
    // MARK: Properties - Output
    let doItems = BehaviorRelay<[ViewDoItem]>(value: [])
    // ViewReferesh
    
    init(realmUseCase: RealmUseCase){
        self.realmUseCase = realmUseCase
        
        let selectMenu = BehaviorSubject<String>(value: "Daily")
        
        selectMenuObserver = selectMenu.asObserver()
        
    }
    
    
    
}
