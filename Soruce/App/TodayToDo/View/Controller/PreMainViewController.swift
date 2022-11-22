import UIKit
import RxCocoa
import RxSwift
import RxGesture
import SwiftUI


class PreMainViewController: BaseViewController {
    
    var delegate: MainViewControllerDelegate?

    let doTableViewModel: DoTableViewModel
    let navigationViewModel: NavigationViewModel
    
    let containerView: UIStackView = {
        let stack = VStackView()
        stack.chain
            .distribution(.fill)
        return stack
    }()
    
    let navigationView: NavigationView = {
       var naviView = NavigationView()
        naviView.setOption(isOnLeftButton: false, isOnRightButton: false, isOnTitle: true, isOnMenuBar: true)
        return naviView
    }()
    
    let doTableView: DoTableView = {
        var tableView = DoTableView()
        
        return tableView
    }()
    
    let tabView: TabView = {
        var tabView = TabView()
        
        return tabView
    }()
    // MARK Properties
    
    required init(doTableViewModel: DoTableViewModel) {
        self.doTableViewModel = doTableViewModel
        self.navigationViewModel = NavigationViewModel()
        super.init(nibName: nil, bundle: nil)
        //bind()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        print("MainViewController viewDidLoad()")
        super.viewDidLoad()
        configureUI()
        configureBinding()
        configureLayer()
        tabView.addDoButton.addTarget(self, action: #selector(testEvent), for: .touchDown)
        doTableViewModel.load(filterString: "", filterType: .none)
    }
    override func viewDidAppear(_ animated: Bool) {
        print("MainViewController viewDidAppear()")
        super.viewDidAppear(animated)
    }
    
    @objc func testEvent(){
        //doTableViewModel.add()
        //let popUp = PopUpView().initView(title: "Message", subTitle: "알람을 추가하시겠습니까?")
        //popUp.showPopUp(parent: self.view)
        
    }
    
    func configureUI(){
        print("\(self) \(#function)")
        containerView.chain
            .add(to: view)
            .edgeTo(view, isSetSafeArea: true)
        
        navigationView.chain
            .add(to: containerView)
            .constraint{ (make) in
                make.height.equalTo(110)
                make.width.equalToSuperview()
            }
        
        doTableView.chain
            .add(to: containerView)
        
        tabView.chain
            .add(to: containerView)
            .constraint{ (make) in
                make.height.equalTo(100)
                make.width.equalToSuperview()
            }
    }
    
    func configureBinding(){
        print("\(self) \(#function)")
        
        navigationView.menuButtons.keys.forEach{ type in
            self.navigationView.menuButtons[type]!.rx.tapGesture()
                .when(.recognized)
                .subscribe(onNext: { _ in
                    self.navigationViewModel.changeNaviMenuType(type: type)
                }
            )
        }
        
        navigationViewModel.selectedMenuType.subscribe(onNext: { type in
            print("doTableViewModel.selectedMenuType.subscribe onNext")
            // 선택 된 type에 맵핑되는 data load
            self.navigationView.changeMenu(type: type)
            if(type == .Done)
            {
                self.doTableViewModel.load(filterString: String(true), filterType: .isDo)
            }
            else
            {
                self.doTableViewModel.load(filterString: type.description, filterType: .dayCycle)
            }
            
        }).disposed(by: disposeBag)

        doTableViewModel.doItems
            .do(onNext: { viewModelItems in
                print("do onNext Start")
                
                print("do onNext End")
            })
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { viewModelItems in
                print("subscribe onNext Start")
                self.doTableView.reloadData(viewModelItems: viewModelItems)
                self.doTableView.doItemViews.forEach{ doItemView in
                    let item = doItemView.doItem
                    doItemView.rx.tapGesture()
                        .when(.recognized)
                        .subscribe(onNext: { element in
                            print(item.doID)
                            }
                        ).disposed(by: self.disposeBag)
                    doItemView.checkButton.rx.tapGesture()
                        .when(.recognized)
                        .subscribe(onNext: { _ in
                            self.tappedDoItemCheck(viewDoItem: item)
                            }
                        ).disposed(by: self.disposeBag)
                    
                    doItemView.deleteButton.rx.tapGesture()
                        .when(.recognized)
                        .subscribe(onNext: { _ in
                            self.tappedDoItemRemove(doItem: item)
                            }
                        ).disposed(by: self.disposeBag)
                    
                    doItemView.editButton.rx.tapGesture()
                        .when(.recognized)
                        .subscribe(onNext: { element in
                            self.tappedDoItemEdit(doItem: item)
                            }
                        ).disposed(by: self.disposeBag)
                }
                self.doTableView.configureLayer()
                print("subscribe onNext End")

            })
            .disposed(by: disposeBag)
        
        tabView.addDoButton.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                self.delegate?.showAddView()
            })
            .disposed(by: disposeBag)
    }
    
    func configureLayer(){
        print("\(self) \(#function)")

        DispatchQueue.main.async {
            self.containerView.chain
                .backgroundGradient(startColor: DesignService.getColorHex(hex: 0xcac9e9), endColor: DesignService.getColorHex(hex: 0x9395D3))
            self.navigationView.configureLayer()
            self.doTableView.configureLayer()
            self.tabView.configureLayer()
        }
    }
}

// UI
extension PreMainViewController{

    func tappedDoItemView(doID: String){
//        let subject = BehaviorSubject<String>(value: "")
//        var test = ""
//        do{
//            test = try subject.value()
//        }catch{
//            test = ""
//        }
    }
    
    func tappedDoItemCheck(viewDoItem: ViewDoItem){
        guard let doID = viewDoItem.doID else { return }
        showPopUp(title: "Do!!", subTitle: "이행 변경 하시겠습니까??").subscribe(onNext: { yesOrNo in
            if(yesOrNo) {
                self.doTableViewModel.checkDoItem(id: doID)
            }
        }).disposed(by: disposeBag)
    }
    
    func tappedDoItemEdit(doItem: ViewDoItem){
        guard let doID = doItem.doID else { return }
        self.delegate?.showEditView(doID: doID)
        // edit 화면 이동
    }
    
    func tappedDoItemRemove(doItem: ViewDoItem){
        guard let doID = doItem.doID else { return }
        showPopUp(title: "Delete!!", subTitle: "정말 삭제 하시겠습니까??").subscribe(onNext: { yesOrNo in
            if(yesOrNo) {
                self.doTableViewModel.delete(id: doID)
            }
        }).disposed(by: disposeBag)
    }
    
    func showPopUp(title: String, subTitle: String) -> Observable<Bool>{
        let popUp = PopUpView()
        return popUp.initView(title: title, subTitle: subTitle).showPopUp(parent: view)
    }
}

