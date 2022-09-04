//
//  Chainable.swift
//  SearchView
//
//  Created by 김태성 on 2022/08/10.
//

import Foundation

protocol ChainAny {
    var anyObject: Any { get }
}

extension Chain: ChainAny{
    var anyObject: Any {
        return origin
    }
}

class Chain<Origin> {
    var origin: Origin
    
    init(origin: Origin){
        self.origin = origin
    }
}

protocol Chainable {
    
}

extension Chainable {
    var chain: Chain<Self>{
        return Chain(origin: self)
    }
}
