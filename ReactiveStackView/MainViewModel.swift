//
//  ViewModel.swift
//  ReactiveStackView
//
//  Created by Ian Dundas on 08/02/2016.
//  Copyright © 2016 IanDundas. All rights reserved.
//

import Foundation
import ReactiveKit

struct MainViewModel{
    
    let count = Observable<Int>(0)
    let allowedHeight = Observable<CGFloat>(0)
    let color = Observable<UIColor>(UIColor.whiteColor())
    
}
