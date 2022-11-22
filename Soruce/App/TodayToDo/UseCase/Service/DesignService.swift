//
//  DesignService.swift
//  TodayToDo
//
//  Created by 김태성 on 2022/09/07.
//

import UIKit

class DesignService{
    enum AxisType { case vertical, horizontal }
    enum CornerRadiusType {  case all, topLeft, topRight, bottomLeft, bottomRight }
    enum DayCycleType: Int, CaseIterable, Comparable
    {
        static func < (lhs: DesignService.DayCycleType, rhs: DesignService.DayCycleType) -> Bool {
            lhs.rawValue < rhs.rawValue
        }
        case Daily = 0, Weekly = 1, Monthly = 2, Yearly = 3
        
        var systemImage: String{
            get {
                switch self {
                case .Daily:
                    return "d.circle"
                case .Weekly:
                    return "w.circle"
                case .Monthly:
                    return "m.circle"
                case .Yearly:
                    return "y.circle"
                }
            }
        }
        
        var description: String {
            get {
                switch self {
                case .Daily:
                    return "Daily"
                case .Weekly:
                    return "Weekly"
                case .Monthly:
                    return "Monthly"
                case .Yearly:
                    return "Yearly"
                }
            }
        }
        
    }
    enum MenuBarButtonType: Int, CaseIterable, Comparable {
        static func < (lhs: DesignService.MenuBarButtonType, rhs: DesignService.MenuBarButtonType) -> Bool {
            lhs.rawValue < rhs.rawValue
        }
        case Daily = 0 , Weekly = 1, Monthly = 2, Yearly = 3, Done = 4
        
        var description: String {
            get {
                switch self {
                case .Daily:
                    return "Daily"
                case .Weekly:
                    return "Weekly"
                case .Monthly:
                    return "Monthly"
                case .Yearly:
                    return "Yearly"
                case .Done:
                    return "Done"
                }
            }
        }
    }
    
    static let purple1 = DesignService.getColorHex(hex: 0x9395D3)
    static let purple3 = DesignService.getColorHex(hex: 0xACB1F5)
    
    static let purple2 = DesignService.getColorHex(hex: 0xB3B7EE)
    
    
    static let gray1 = DesignService.getColorHex(hex: 0xB5B5B5)
    static let gray2 = DesignService.getColorHex(hex: 0xE2E2E2)
    static let gray3 = UIColor.darkGray

    static let white = DesignService.getColorHex(hex: 0xFFFFFF)
    
    static let header1 = UIFont(name: "Arial Bold", size: 30)!
    static let header2 = UIFont(name: "Arial Bold", size: 20)!
    static let header3 = UIFont(name: "Arial Bold", size: 15)!
    
    static let content1 = UIFont(name: "Arial", size: 18)!
    static let content2 = UIFont(name: "Arial", size: 12)!
    static let content3 = UIFont(name: "Arial", size: 6)!
    
    
    
    static let commonNaviTitle = "오늘 하루Do!"
    
    static func getColorHex(hex: Int) -> UIColor{
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        return UIColor(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
    
    static func combineImageAndText(systemName: String , text: String) -> NSMutableAttributedString{
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: systemName)?.withTintColor(gray2)
        
        let combineText = NSMutableAttributedString(attachment: imageAttachment)
        combineText.append(NSAttributedString(string: " \(text)"))
        
        return combineText
    }
    
    static func paintSpacer(axis: NSLayoutConstraint.Axis, length: CGFloat) -> UIView{
        
        let container = UIView()
        
        let firstSpacer = UIView()
        let secondSpacer = UIView()
        let thirdSpacer = UIView()
        
        if(axis == .horizontal){
            firstSpacer.chain.size(width: length)
            thirdSpacer.chain.size(width: length)
            
        }
        else{
            firstSpacer.chain.size(height: length)
            thirdSpacer.chain.size(height: length)
        }
        
        secondSpacer.chain.background(color: .white)
        let stack = UIStackView().chain.axis(axis).origin
        stack.chain
            .add(to: container)
            .edgeTo(container, isSetSafeArea: false)
            .spacing(0)
            .distribution(.fill)
            .add(children:
                    firstSpacer,
                 secondSpacer,
                 thirdSpacer
            )
        return container
    }
    
    static func paintSpacer() -> UIView{
        let space = UIView()
        return space
    }
}


