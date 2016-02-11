//
//  ViewModel.swift
//  ReactiveStackView
//
//  Created by Ian Dundas on 08/02/2016.
//  Copyright © 2016 IanDundas. All rights reserved.
//

import Foundation
import ReactiveKit

let validateHeight: (CGFloat)->(CGFloat, Bool) = { height in
    return (height, height < 300)
}

struct MainViewModel{
    
    let MaxHeight = 300
    
    let count = Observable<Int>(0)
    let desiredHeight = Observable<CGFloat>(0)
    let color = Observable<UIColor>(UIColor.whiteColor())
    
    var allowedHeight: Stream<(CGFloat,Bool)> {
        return self.desiredHeight.map(validateHeight)
    }
}
