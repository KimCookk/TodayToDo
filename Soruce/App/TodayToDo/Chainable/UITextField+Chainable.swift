//
//  UITextField+Chainable.swift
//  UIKitToSwiftUI
//
//  Created by 김태성 on 2022/08/10.
//

import UIKit

extension Chain where Origin: UITextField{
    func boarderStyle(_ style: UITextField.BorderStyle) -> Chain{
        origin.borderStyle = style
        return self
    }
    
    func keyboard(_ type: UIKeyboardType) -> Chain{
        origin.keyboardType = type
        return self
    }
    
    func secure(_ enabled: Bool) -> Chain{
        origin.isSecureTextEntry = enabled
        return self
    }
    
    @discardableResult
    func text(text: String) -> Chain{
        origin.text = text
        return self
    }
    
    @discardableResult
    func font(font: UIFont, color: UIColor) -> Chain{
        origin.font = font
        origin.textColor = color
        return self
    }
    
    @discardableResult
    func textAligment(align: NSTextAlignment) -> Chain{
        origin.textAlignment = align
        return self
    }
    
    @discardableResult
    func placeholder(text: String, font: UIFont, color: UIColor) -> Chain{
        origin.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.font : font , NSAttributedString.Key.foregroundColor : color])
        origin.placeholder = text
        return self
    }
    
    func setPadding(left: CGFloat = 0 , right: CGFloat = 0) -> Chain{
        
        if(left != 0)
        {
            let leftPadding = UIView()

            leftPadding.chain.size(width: left)
            origin.leftView = leftPadding
            origin.leftViewMode = .always
        }
        if(right != 0)
        {
            let rightPadding = UIView()
            rightPadding.chain.size(width: right)
            origin.rightView = rightPadding
            origin.rightViewMode = .always
        }
        return self
    }
    
   

}
