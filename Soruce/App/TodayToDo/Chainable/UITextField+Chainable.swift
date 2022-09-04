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
}
