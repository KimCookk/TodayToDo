import Foundation
import RxSwift
import RxRelay

class NavigationViewModel{
    
    let selectedMenuType = BehaviorRelay<DesignService.MenuBarButtonType>(value: .Daily)

    func changeNaviMenuType(type: DesignService.MenuBarButtonType){
        print("\(selectedMenuType.value) -> \(type)")
        if(selectedMenuType.value != type)
        {
            selectedMenuType.accept(type)
        }
    }
}
