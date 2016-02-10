//
//  InputStackItem.swift
//  ReactiveStackView
//
//  Created by Ian Dundas on 10/02/2016.
//  Copyright © 2016 IanDundas. All rights reserved.
//

import UIKit
import ReactiveKit
import ReactiveUIKit


class SliderStackItem: UIView{
    
    @IBOutlet private weak var slider: UISlider!
    @IBOutlet weak var label: UILabel!
    
    lazy var value: Observable<Float> = self.slider.rValue
    
    func setMin(min: Float, max:Float){
        slider.minimumValue = min
        slider.maximumValue = max
    }
}
