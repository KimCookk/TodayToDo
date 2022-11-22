import Foundation
import UIKit

protocol DoEditViewControllerDelegate{
    func backMainView()
}

class DoEditViewController: BaseViewController{

    var delegate: DoEditViewControllerDelegate?
    let doEditViewModel: DoEditViewModel

    let containerView: UIStackView = {
        let stack = VStackView()
        stack.chain
            .distribution(.fill)
        return stack
    }()
    
    let navigationView: NavigationView = {
        var naviView = NavigationView()
        naviView.setOption(naviTitle: "Edit Do!", isOnLeftButton: true, isOnRightButton: false, isOnTitle: true, isOnMenuBar: false)
        return naviView
    }()
    
    let doEditView: DoEditView = {
        var editView = DoEditView()
        
        return editView
    }()
    
    let tabView: TabView = {
        var tabView = TabView()
        tabView.setOption(isOnAdd: false, isOnAlarm: false)
        return tabView
    }()
    
    required init(doEditViewModel: DoEditViewModel) {
        self.doEditViewModel = doEditViewModel
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
        
        doEditView.chain
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
        navigationView.leftButton.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                self.delegate?.backMainView()
            })
            .disposed(by: disposeBag)
        
       
        doEditViewModel.editDoItem
            .subscribe(onNext: { editDo in
                guard let editDo = editDo else { return }
                self.doEditView.paintView(editDo: editDo)
            })
            .disposed(by: disposeBag)
        
        doEditView.dayTypeButtons.forEach{ (dayCycleType, button) in
            button.rx.tapGesture()
                .when(.recognized)
                .map{ _ in
                    self.doEditView.selectButton(dayCycle: dayCycleType.description)
                    return dayCycleType.description
                }.bind(to: doEditViewModel.dayTypeObserver)
                .disposed(by: disposeBag)
        }
        
        doEditView.titleTextField.rx.controlEvent(.editingDidEnd)
            .map{
                guard let title = self.doEditView.titleTextField.text else {
                    return ""
                }
                return title
            }.bind(to: doEditViewModel.titleObserver)
            .disposed(by: disposeBag)
        
        doEditView.subTitleTextField.rx.controlEvent(.editingDidEnd)
            .map{
                guard let content = self.doEditView.subTitleTextField.text else {
                    return ""
                }
                return content
            }.bind(to: doEditViewModel.contentObserver)
            .disposed(by: disposeBag)
        
        doEditView.editButton.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                self.tappedEditButton()
            })
            .disposed(by: disposeBag)
    }
    
    func configureLayer(){
        print("\(self) \(#function)")
        DispatchQueue.main.async {
            self.containerView.chain.backgroundGradient(startColor: DesignService.getColorHex(hex: 0xcac9e9), endColor: DesignService.getColorHex(hex: 0x9395D3))
            self.navigationView.configureLayer()
            self.doEditView.configureLayer()
            self.tabView.configureLayer()
        }
    }
    
    func tappedEditButton(){
        let popUp = PopUpView()
        popUp.initView(title: "Message", subTitle: "해당 To-Do 수정할까요?")
        popUp.showPopUp(parent: self.view).subscribe(onNext: { result in
            if(result){
                self.doEditViewModel.editDoEventObserver.onNext(true)
                self.delegate?.backMainView()
            }
        })
    }
    
}

extension DoEditViewController{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}
