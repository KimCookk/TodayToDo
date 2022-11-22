//
//  UILabel+Chainable.swift
//  UIKitToSwiftUI
//
//  Created by 김태성 on 2022/08/09.
//

import UIKit

extension Chain where Origin: UILabel{
    func text(_ text: String) -> Chain{
        origin.text = text
        return self
    }
    
    func font(_ font: UIFont) -> Chain{
        origin.font = font
        return self
    }
    
    func align(_ textAlign: NSTextAlignment) -> Chain{
        origin.textAlignment = textAlign
        return self
    }
    
    func sizeToFit() -> Chain{
        origin.sizeToFit()
        return self
    }
    
    func font(size: CGFloat , weight: UIFont.Weight) -> Chain{
        return font(UIFont.systemFont(ofSize: size, weight: weight))
    }
    
    
    @discardableResult
    func text(text: String) -> Chain{
        origin.text = text
        return self
    }
    
    func text(attributeText: NSAttributedString) -> Chain{
        origin.attributedText = attributeText
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
    
}
