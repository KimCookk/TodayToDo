import UIKit

class DoAddView: BaseView{
    lazy var stackView: UIStackView = {
       let stack = VStackView()
        stack.chain
            .spacing(20)
            .distribution(.fillEqually)
            .layoutMargins(NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        
        return stack
    }()
    
    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.chain
            .setPadding(left: 10, right: 10)
            .background(color: DesignService.purple2)
            .cornerRadius(15, radiusOpts: .all)
            .font(font: DesignService.header3, color: DesignService.white)
            .placeholder(text: "TODO TITLE", font: DesignService.header3, color: DesignService.gray2)
        
        return textField
    }()
    
    lazy var subTitleTextField: UITextField = {
        let textField = UITextField()
        textField.chain
            .setPadding(left: 10, right: 10)
            .background(color: DesignService.purple2)
            .cornerRadius(15, radiusOpts: .all)
            .font(font: DesignService.header3, color: DesignService.white)
            .placeholder(text: "TODO SUBTITLE", font: DesignService.header3, color: DesignService.gray2)

        return textField
    }()
    
    lazy var typeStackView: UIStackView = {
       let stack = HStackView()
        stack.chain
            .spacing(5)
            .distribution(.fillEqually)
            .background(color: DesignService.purple2)
            .cornerRadius(15, radiusOpts: .all)
            .layoutMargins(NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        return stack
    }()
    
    lazy var dayTypeButton: [DesignService.DayCycleType: UIButton] = {
        var bars = [DesignService.DayCycleType: UIButton]()
        DesignService.DayCycleType.allCases.forEach{ (dayType) in
            let button = UIButton()
            if(dayType == .Daily){
                button.chain
                    .setImage(UIImage(systemName: dayType.systemImage)?.withRenderingMode(.alwaysTemplate))
                    .tintColr(color: DesignService.gray3)
            }
            else{
                button.chain
                    .setImage(UIImage(systemName: dayType.systemImage)?.withRenderingMode(.alwaysTemplate))
                    .tintColr(color: DesignService.gray2)
            }
            
            bars[dayType] = button
        }
        return bars
    }()
    
    lazy var addButton: UIButton = {
       let button = UIButton()
        button.chain
            .background(color: DesignService.white)
            .cornerRadius(15, radiusOpts: .all)
            .font(font: DesignService.header2, color: DesignService.gray1)
            .title("ADD TODO")

        return button
    }()
    
    override func configureView() {
        stackView.chain
            .add(to: self)
            .constraint{ (make) in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
                make.width.equalToSuperview()
                make.height.equalTo(300)
            }
        typeStackView.chain
            .add(to: stackView)
        
        dayTypeButton.keys.sorted().forEach{
            dayTypeButton[$0]?.chain
                .add(to: typeStackView)
        }
        
        titleTextField.chain
            .add(to: stackView)
        
        subTitleTextField.chain
            .add(to: stackView)
        
        addButton.chain
            .add(to: stackView)
    }
    
    override func configureLayer() {
        titleTextField.chain.paintShadow()
        subTitleTextField.chain.paintShadow()
        addButton.chain.paintShadow()
        typeStackView.chain.paintShadow()
    }
    
    func paintView() {
        
    }
    
    func paintShadow(){
      

        //titleTextField.chain.paintLine(y: 20, x: 10, weight: 3, color: DesignService.white.cgColor)
        //subTitleTextField.chain.paintLine(y: 20, x: 10, weight: 3, color: DesignService.white.cgColor)
    }
}

