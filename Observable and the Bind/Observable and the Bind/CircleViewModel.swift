//
//  CircleViewModel.swift
//  Observable and the Bind
//
//  Created by Wayne Kim on 19/03/2019.
//  Copyright © 2019 Wayne Kim. All rights reserved.
//

import UIKit
import ChameleonFramework
import RxSwift
import RxCocoa

class CircleViewModel {
    var centerVariable = BehaviorRelay<CGPoint?>(value: .zero)
    
    var backgroundColorObservable: Observable<UIColor>!
    var cornerRadiusObservable: Observable<CGFloat>!
    
    init() {
        setup()
    }
    
    func setup() {
        backgroundColorObservable = centerVariable.asObservable()
            .map { center in
                guard let center = center else { return UIColor.black }
                
                let red: CGFloat = ((center.x + center.y).truncatingRemainder(dividingBy: 255.0)) / 255.0
                let green: CGFloat = 0.0
                let blue: CGFloat = 0.0
                
                return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
        
        cornerRadiusObservable = centerVariable.asObservable()
            .map { center in
                guard let center = center else { return 0 }
                return center.y.truncatingRemainder(dividingBy: 100.0) / 2.0
        }
    }
}
