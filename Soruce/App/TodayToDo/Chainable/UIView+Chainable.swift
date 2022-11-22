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
    @discardableResult
    func background(color: UIColor, alpha: CGFloat = 1) -> Chain{
        origin.backgroundColor = color.withAlphaComponent(alpha)
        return self
    }
    
    @discardableResult
    func backgroundGradient(startColor: UIColor, endColor: UIColor) -> Chain{
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x : 0.0, y : 0)
        gradient.endPoint = CGPoint(x :0.0, y: 1.0) // you need to play with 0.15 to adjust gradient vertically
        gradient.frame = origin.frame
        origin.layer.insertSublayer(gradient, at: 0)
        return self
    }
    
    @discardableResult
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
    
    @discardableResult
    func paintShadow() -> Chain{
        origin.layer.masksToBounds = false
        origin.layer.shadowOffset = CGSize(width: 0, height: 5)
        origin.layer.shadowOpacity = 0.3
        origin.layer.shouldRasterize = true
        origin.layer.shadowPath = UIBezierPath(roundedRect: origin.bounds, cornerRadius: origin.layer.cornerRadius).cgPath
        
        return self
    }
    
    @discardableResult
    func paintLine(y: CGFloat, x: CGFloat, length: CGFloat, weight: CGFloat, color: CGColor, type: DesignService.AxisType) -> Chain{
        var frame = origin.bounds
        frame.origin.y = frame.size.height - y
        frame.origin.x = frame.origin.x + x
        if(type == .horizontal)
        {
            frame.size.width = length
            frame.size.height = weight
        }
        else
        {
            frame.size.width = weight
            frame.size.height = length
        }
        
        let line = CALayer()
        line.frame = frame
        line.backgroundColor = color
        origin.layer.addSublayer(line)
        
        return self
    }
    
    @discardableResult
    func clearLayer() -> Chain{
        origin.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        return self
    }
    
    @discardableResult
    func size(width: CGFloat = 0, height: CGFloat = 0) -> Chain{
        origin.translatesAutoresizingMaskIntoConstraints = false
        origin.widthAnchor
            .constraint(equalToConstant: width)
            .isActive = true
        origin.heightAnchor
            .constraint(equalToConstant: height)
            .isActive = true
        
        return self
    }
    
    @discardableResult
    func edgeTo(_ view: UIView, isSetSafeArea: Bool) -> Chain{
        if(isSetSafeArea){
            self.constraint{ (make) in
                make.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            }
        }
        else{
            self.constraint{ (make) in
                make.edges.equalToSuperview()
                
            }
        }
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
    
    @discardableResult
    func addBorder(_ arr_edge: UIRectEdge..., color: UIColor, width: CGFloat) -> Chain {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: origin.frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: origin.frame.height - width, width: origin.frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: origin.frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: origin.frame.width - width, y: 0, width: width, height: origin.frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            origin.layer.addSublayer(border)
        }
        return self
    }
    
    private func add(child: UIView, to parent: UIView, at: Int = -1){
        if let stackParent = parent as? UIStackView {
            if(at >= 0)
            {
                stackParent.insertArrangedSubview(child, at: at)
            }
            else
            {
                stackParent.addArrangedSubview(child)
            }
        }
        else{
            parent.addSubview(child)
        }
    }
    
    @discardableResult
    func add<PARENT: UIView>(to parent: PARENT, at: Int = -1) -> Chain{
        add(child: origin, to: parent, at: at)
        return self
    }
    
    func add<V: UIView>(to parentChain: Chain<V>, at: Int = -1) -> Chain{
        return add(to: parentChain.origin, at: at)
    }
    func add<V: UIView>(child: V) -> Chain{
        add(child: child, to: origin)
        return self
    }
    
    func add<V: UIView>(child: Chain<V>) -> Chain{
        return add(child: child.origin)
    }

    
    @discardableResult
    func add<V: UIView>(children: V...) -> Chain{
        children.forEach { child in add(child: child, to: origin)}
        return self
    }
    
    @discardableResult
    func add(children: ChainAny...) -> Chain{
        children.map { $0.anyObject }
            .map { $0 as! UIView }
            .forEach{ child in add(child: child, to: origin)}
        return self
    }
    
    @discardableResult
    func process(pro: () -> Void) -> Chain{
        pro()
        return self
    }
}
