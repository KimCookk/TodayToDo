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
    
    @discardableResult
    func titleColor(color: UIColor, state: UIControl.State = .normal) -> Chain{
        origin.setTitleColor(color, for: state)
        origin.tintColor = color
        return self
    }
    
    @discardableResult
    func tintColr(color: UIColor) -> Chain{
        origin.tintColor = color
        return self
    }
    
    func cornerRadius(_ r: CGFloat, radiusOpts: DesignService.CornerRadiusType...) -> Chain{
        origin.layer.cornerRadius = r
        origin.clipsToBounds = true
        origin.layer.maskedCorners = []
        radiusOpts.forEach { (radiusOpt) in
            switch radiusOpt {
            case .all:
                origin.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
            case .bottomLeft:
                origin.layer.maskedCorners.insert(.layerMinXMaxYCorner)
            case .bottomRight:
                origin.layer.maskedCorners.insert(.layerMaxXMaxYCorner)
            case .topLeft:
                origin.layer.maskedCorners.insert(.layerMinXMinYCorner)
            case .topRight:
                origin.layer.maskedCorners.insert(.layerMaxXMinYCorner)
            }
        }
        return self
    }
    
    func borderColor(color: CGColor) -> Chain{
        origin.layer.borderColor = color
        origin.layer.borderWidth = 1
        return self
    }
    
    func titleFont(_ font: UIFont) -> Chain{
        origin.titleLabel?.font = font
        return self
    }
    
    @discardableResult
    func setImage(_ image: UIImage?) -> Chain{
        origin.setImage(image, for: .normal)
        return self
    }
    
    @discardableResult
    func setSizeImage(size: CGFloat) -> Chain{
        origin.setPreferredSymbolConfiguration(.init(pointSize: size, weight: .regular, scale: .default), forImageIn: .normal)
        return self
    }

    
    func titleFont(size: CGFloat , weight: UIFont.Weight) -> Chain{
        return titleFont (UIFont.systemFont(ofSize: size, weight: weight))
    }
    
    func addTarget(target: Any?, action: Selector, event: UIControl.Event) -> Chain{
        origin.addTarget(target, action: action, for: event)
        return self
    }
    
    @discardableResult
    func font(font: UIFont, color: UIColor) -> Chain{
        origin.titleLabel?.font  = font
        origin.setTitleColor(color, for: .normal)
        
        return self
    }
}
