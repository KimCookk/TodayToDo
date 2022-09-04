//
//  Int+Chainable.swift
//  SearchView
//
//  Created by 김태성 on 2022/08/10.
//

import Foundation
extension Int: Chainable{
    
}

extension Chain where Origin == Int{
    func increase() -> Chain{
        origin += 1
        return self
    }
    
    func decrease() -> Chain{
        origin -= 1
        return self
    }
}
