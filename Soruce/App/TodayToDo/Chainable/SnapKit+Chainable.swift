//
//  SnapKit+Chainable.swift
//  SearchView
//
//  Created by 김태성 on 2022/08/15.
//

import UIKit
import SnapKit

extension Chain where Origin: UIView{
    @discardableResult
    func constraint(_ maker: @escaping (ConstraintMaker) -> Void) -> Chain{
//        if let _ = origin.superview{
//            origin.snp.makeConstraints(maker)
//        } else{
//            _ = origin.rx.didMoveToSuperView
//                .take(1)
//                .subscribe(onNext: { _ in
//                    self.origin.snp.makeConstraints(maker)
//                })
//        }
        if let _ = origin.superview{
            origin.snp.makeConstraints(maker)
        }
        return self
    }
    
    func updateConstraint(_ maker: @escaping (ConstraintMaker) -> Void) -> Chain{
        if let _ = origin.superview{
            origin.snp.updateConstraints(maker)
        }
        return self
    }
}
