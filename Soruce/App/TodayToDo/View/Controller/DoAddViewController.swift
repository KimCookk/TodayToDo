import UIKit
import RxGesture
import RxSwift
import RxCocoa

protocol DoAddViewControllerDelegate{
    func backMainView()
}

class DoAddViewController: BaseViewController{
    
    var delegate: DoAddViewControllerDelegate?
    let doAddViewModel: DoAddViewModel
    
    let containerView: UIStackView = {
        let stack = VStackView()
        stack.chain
            .distribution(.fill)
        return stack
    }()
    
    let navigationView: NavigationView = {
        var naviView = NavigationView()
        naviView.setOption(naviTitle: "ADD Do!", isOnLeftButton: true, isOnRightButton: false, isOnTitle: true, isOnMenuBar: false)
        return naviView
    }()
    
    let doAddView: DoAddView = {
        var addView = DoAddView()
        
        return addView
    }()
    
    let tabView: TabView = {
        var tabView = TabView()
        tabView.setOption(isOnAdd: false, isOnAlarm: false)
        return tabView
    }()
    
    required init(doAddViewModel: DoAddViewModel) {
        self.doAddViewModel = doAddViewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureBinding()
        configureLayer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
        
        doAddView.chain
            .add(to: containerView)
        
        tabView.chain
            .add(to: containerView)
            .constraint{ (make) in
                make.height.equalTo(100)
                make.width.equalToSuperview()
            }
    }
    
    func configureLayer(){
        print("\(self) \(#function)")
        DispatchQueue.main.async {
            self.containerView.chain.backgroundGradient(startColor: DesignService.getColorHex(hex: 0xcac9e9), endColor: DesignService.getColorHex(hex: 0x9395D3))
            self.navigationView.configureLayer()
            self.doAddView.configureLayer()
            self.tabView.configureLayer()
        }
    }
    
    func configureBinding(){
        print("\(self) \(#function)")
        navigationView.leftButton.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                self.delegate?.backMainView()
            })
            .disposed(by: disposeBag)
        
        doAddView.dayTypeButton.forEach{ (dayCycleType, button) in
            button.rx.tapGesture()
                .when(.recognized)
                .map{ _ in
                    self.selectedDayCycleType(cycleType: dayCycleType)
                    return dayCycleType.description
                }.bind(to: doAddViewModel.selectedDayType)
                .disposed(by: disposeBag)
        }
        
        doAddView.titleTextField.rx.controlEvent(.editingDidEnd)
            .map{
                guard let title = self.doAddView.titleTextField.text else {
                    return ""
                }
                return title
            }.bind(to: doAddViewModel.inputTitle)
            .disposed(by: disposeBag)
        
        doAddView.subTitleTextField.rx.controlEvent(.editingDidEnd)
            .map{
                guard let content = self.doAddView.subTitleTextField.text else {
                    return ""
                }
                return content
            }.bind(to: doAddViewModel.inputContent)
            .disposed(by: disposeBag)
        
        doAddView.addButton.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                let checkedInput = self.doAddViewModel.checkedInput
                print(checkedInput)
                self.tappedAddButton(checkedInput: checkedInput)
                
            })
            .disposed(by: disposeBag)
    }
    
    func selectedDayCycleType(cycleType: DesignService.DayCycleType){
        DispatchQueue.main.async { [weak self] in
            self?.doAddView.dayTypeButton.forEach{ (dayCycleType, button) in
                if(cycleType == dayCycleType){
                    button.chain.tintColr(color: .darkGray)
                }
                else{
                    button.chain.tintColr(color: DesignService.gray2)
                }
            }
        }
    }
    
    func tappedAddButton(checkedInput: Bool){
        let popUp = PopUpView()
        if(self.doAddViewModel.checkedInput){
            popUp.initView(title: "Message", subTitle: "새로운 To-Do 생성할까요?")
            popUp.showPopUp(parent: self.view).subscribe(onNext: { result in
                if(result){
                    self.doAddViewModel.addDoEvent.onNext(true)
                    self.delegate?.backMainView()
                }
            })
        } else{
            popUp.initView(title: "Message", subTitle: "To-Do 의 Cycle, Title 입력해주세요!")
            popUp.showPopUp(parent: self.view)
        }
    }
    
}

// UI Extension
extension DoAddViewController{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}
