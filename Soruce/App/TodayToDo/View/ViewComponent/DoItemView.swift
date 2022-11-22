import UIKit

class DoItemView: BaseDoItemView{
    var doItem: ViewDoItem = ViewDoItem()
    
    let container: UIStackView = {
         let stack = HStackView()
         stack.chain
             .distribution(.fill)
         
         return stack
     }()
    
    lazy var itemCotainer: UIStackView = {
        let view = VStackView()
        view.chain
            .distribution(.fill)
            .layoutMargins(NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        
        return view
    }()
    
    lazy var functionContainer: UIStackView = {
        let view = HStackView()
        view.chain
            .distribution(.fillEqually)
        
        return view
    }()
    
    lazy var itemTitleLabel: UILabel = {
        let label = UILabel()
        label.chain.font(font: DesignService.content1, color: DesignService.white)
        return label
    }()
    
    lazy var itemContentLabel: UILabel = {
        let label = UILabel()
        label.chain.font(font: DesignService.content2, color: DesignService.gray2)
        return label
    }()
    
    lazy var typeLabel: UIButton = {
        let label = UIButton()
        label.chain
            .setImage(UIImage(systemName: "d.circle")?.withTintColor(.white , renderingMode: .alwaysOriginal))
            .setSizeImage(size: 15)
        return label
    }()
    
    lazy var checkButton: UIButton = {
        let button = UIButton()
        button.chain
            .setImage(UIImage(systemName: "square")?.withTintColor(.white , renderingMode: .alwaysOriginal))
            .setSizeImage(size: 30)
        return button
    }()
    
    lazy var editButton: UIButton = {
        let button = UIButton()
        button.chain
            .setImage(UIImage(systemName: "square.and.pencil")?.withTintColor(.white , renderingMode: .alwaysOriginal))
            .setSizeImage(size: 30)
        return button
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.chain
            .setImage(UIImage(systemName: "trash")?.withTintColor(.white , renderingMode: .alwaysOriginal))
            .setSizeImage(size: 30)
        return button
    }()

    override func configureView(item: ViewDoItem? = nil) {
        guard let item = item else { return }
        
        doItem = item
        
        self.chain
            .background(color: DesignService.purple2)
            .cornerRadius(15, radiusOpts: .all)
            .constraint{ (make) in
                make.height.equalTo(80)
            }

        container.chain
            .add(to: self)
            .edgeTo(self, isSetSafeArea: false)

        itemCotainer.chain
            .add(to: container)
            .constraint{ (make) in
                make.width.equalTo(220)
            }

        functionContainer.chain
            .add(to: container)

        itemTitleLabel.chain
            .add(to: itemCotainer)
            .process {
                guard let dayCycle = item.dayCycle else { return }
                var dayType = DesignService.DayCycleType.Daily
                switch(dayCycle){
                case DesignService.MenuBarButtonType.Yearly.description:
                    dayType = DesignService.DayCycleType.Yearly
                    break
                case DesignService.MenuBarButtonType.Monthly.description:
                    dayType = DesignService.DayCycleType.Monthly
                    break
                case DesignService.MenuBarButtonType.Weekly.description:
                    dayType = DesignService.DayCycleType.Weekly
                    break
                case DesignService.MenuBarButtonType.Daily.description:
                    break
                default:
                    break
                }
                itemTitleLabel.chain.text(attributeText: DesignService.combineImageAndText(systemName: dayType.systemImage, text: item.doTitle!))
            }
            .constraint{ (make) in
                //make.width.equalToSuperview()
                make.height.equalTo(40)
            }

        itemContentLabel.chain
            .add(to: itemCotainer)
            .text(text:  item.doSubTitle!)
            .constraint{ (make) in
               // make.width.equalToSuperview()
                make.height.equalTo(30)
            }
        
        checkButton.chain
            .add(to: functionContainer)
            .process {
                guard let isDo = item.isDo else { return }
                if(isDo){
                    checkButton.chain
                        .setImage(UIImage(systemName: "checkmark.square")?.withTintColor(.white , renderingMode: .alwaysOriginal))
                }
                else{
                    checkButton.chain
                        .setImage(UIImage(systemName: "square")?.withTintColor(.white , renderingMode: .alwaysOriginal))
                }
            }

        editButton.chain
            .add(to: functionContainer)

        deleteButton.chain
            .add(to: functionContainer)
    }
}

