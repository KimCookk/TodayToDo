//
//  UIView+Chainable.swift
//  SearchView
//
//  Created by 김태성 on 2022/08/11.
//
import UIKit

extension UIView: Chainable{
    
}

extension Chain where Origin: UIView{
    func background(color: UIColor) -> Chain{
        origin.backgroundColor = color
        return self
    }
    
    func cornerRadius(_ r: CGFloat) -> Chain{
        origin.layer.cornerRadius = r
        origin.clipsToBounds = true
        return self
    }
   
    func size(width: CGFloat , height: CGFloat) -> Chain{
        origin.translatesAutoresizingMaskIntoConstraints = false
        origin.widthAnchor
            .constraint(equalToConstant: width)
            .isActive = true
        origin.heightAnchor
            .constraint(equalToConstant: height)
            .isActive = true
        
        return self
    }
    
    func posistion(x: CGFloat , y: CGFloat) -> Chain{
        guard let parent = origin.superview else { return self }
        origin.translatesAutoresizingMaskIntoConstraints = false
        origin.leadingAnchor
            .constraint(equalTo: parent.leadingAnchor , constant: x)
            .isActive = true
        origin.topAnchor
            .constraint(equalTo: parent.topAnchor, constant: y)
            .isActive = true
        return self
    }
    
    private func add(child: UIView, to parent: UIView){
        if let stackParent = parent as? UIStackView {
            stackParent.addArrangedSubview(child)
        }
        else{
            parent.addSubview(child)
        }
    }
    func add<PARENT: UIView>(to parent: PARENT) -> Chain{
        add(child: origin, to: parent)
        return self
    }
    
    func add<V: UIView>(to parentChain: Chain<V>) -> Chain{
        return add(to: parentChain.origin)
    }
    func add<V: UIView>(child: V) -> Chain{
        add(child: child, to: origin)
        return self
    }
    
    func add<V: UIView>(child: Chain<V>) -> Chain{
        return add(child: child.origin)
    }
    
    func add<V: UIView>(children: V...) -> Chain{
        children.forEach { child in add(child: child, to: origin)}
        return self
    }
    func add(children: ChainAny...) -> Chain{
        children.map { $0.anyObject }
                .map { $0 as! UIView }
                .forEach{ child in add(child: child, to: origin)}
        return self
    }
}
