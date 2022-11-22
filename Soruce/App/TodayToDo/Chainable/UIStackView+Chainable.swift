//
//  UIStackView+Chainable.swift
//  UIKitToSwiftUI
//
//  Created by 김태성 on 2022/08/10.
//

import UIKit

extension Chain where Origin: UIStackView{
    
    @discardableResult
    func axis(_ axis: NSLayoutConstraint.Axis) -> Chain{
        origin.axis = axis
        return self
    }
    
    @discardableResult
    func spacing(_ space: CGFloat) -> Chain{
        origin.spacing = space
        return self
    }
    
    @discardableResult
    func alignment(_ alignment: UIStackView.Alignment) -> Chain{
        origin.alignment = alignment
        return self
    }
    
    @discardableResult
    func distribution(_ distribution: UIStackView.Distribution) -> Chain{
        origin.distribution = distribution
        return self
    }
    
    @discardableResult
    func layoutMargins(_ margins: NSDirectionalEdgeInsets) -> Chain{        
        origin.isLayoutMarginsRelativeArrangement = true
        origin.directionalLayoutMargins = margins
        return self
    }
}

func HStackView() -> UIStackView{
    return UIStackView().chain.axis(.horizontal).origin
}

func VStackView() -> UIStackView{
    return UIStackView().chain.axis(.vertical).origin
}

//func Spacer(width: CGFloat? = 1 , height: CGFloat? = 1) -> UIView {
//    return UIView().chain.constraint{ make in
//        if let w = width { make.width.equalTo(w)}
//        if let h = height { make.height.equalTo(h)}
//    }.origin
//}

