import RxSwift
import Combine
import UIKit

class BaseViewController: UIViewController{
    
    //MARK : Properties
    let disposeBag = DisposeBag()
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .darkContent
//    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad(){
        view.backgroundColor = DesignService.purple1
        configureBaseUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configureBaseLayer()
    }
    
    
    func configureBaseUI(){
        
    }
    
    func configureBaseLayer(){
        
    }
    
    
}
