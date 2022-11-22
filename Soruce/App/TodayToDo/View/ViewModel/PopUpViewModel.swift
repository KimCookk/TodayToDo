//
//  PopUpViewModel.swift
//  TodayToDo
//
//  Created by 김태성 on 2022/10/09.
//

import Foundation
import RxSwift
import RxRelay

class PopUpViewModel{
    
    enum EventType { case PopUp, Ok, Close }
    
    let status = BehaviorRelay<EventType>(value: .Close)
    
}
