//
//  UIButton+Chainable.swift
//  UIKitToSwiftUI
//
//  Created by 김태성 on 2022/08/10.
//

import UIKit

extension Chain where Origin: UIButton{
    
    func title(_ text: String, state: UIControl.State = .normal) -> Chain{
        origin.setTitle(text, for: state)
        return self
    }
    
    func titleColor(color: UIColor, state: UIControl.State = .normal) -> Chain{
        origin.setTitleColor(color, for: state)
        return self
    }
    
    func titleFont(_ font: UIFont) -> Chain{
        origin.titleLabel?.font = font
        return self
    }
    
    func setImage(_ image: UIImage?) -> Chain{
        origin.setImage(image, for: .normal)
        return self
    }
    
    func titleFont(size: CGFloat , weight: UIFont.Weight) -> Chain{
        return titleFont (UIFont.systemFont(ofSize: size, weight: weight))
    }
    
    func addTarget(target: Any?, action: Selector, event: UIControl.Event) -> Chain{
        origin.addTarget(target, action: action, for: event)
        return self
    }
}
