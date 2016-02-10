//
//  ColorStackItem.swift
//  ReactiveStackView
//
//  Created by Ian Dundas on 10/02/2016.
//  Copyright © 2016 IanDundas. All rights reserved.
//

import UIKit
import ReactiveKit
import ReactiveUIKit


class ColorStackItem: UIView{
    
    @IBOutlet weak var colorButtonA: UIButton!
    @IBOutlet weak var colorButtonB: UIButton!
    @IBOutlet weak var colorButtonC: UIButton!
    @IBOutlet weak var colorButtonD: UIButton!
    @IBOutlet weak var colorButtonE: UIButton!
    
    override func awakeFromNib() {
        layer.borderColor = UIColor.whiteColor().CGColor
        layer.borderWidth = 1
    }
    var colorStream:Stream<UIColor>{
        let toBackgroundColor = {(button: UIButton) in button.backgroundColor}
        
        let a = colorButtonA.rTapWithButton.map(toBackgroundColor).ignoreNil()
        let b = colorButtonB.rTapWithButton.map(toBackgroundColor).ignoreNil()
        let c = colorButtonC.rTapWithButton.map(toBackgroundColor).ignoreNil()
        let d = colorButtonD.rTapWithButton.map(toBackgroundColor).ignoreNil()
        let e = colorButtonE.rTapWithButton.map(toBackgroundColor).ignoreNil()
        
        return merge([a,b,c,d,e])
    }
}




extension UIButton {
    
    public var rTapWithButton: ActiveStream<UIButton> {
        
        let tapStream = self.rControlEvent.filter { $0 == UIControlEvents.TouchUpInside }
        let selfStream:Stream<UIButton> = create (producer: { _ in SimpleDisposable() }).startWith(self)
        
        let latest = selfStream.combineLatestWith(tapStream).map { $0.0 }.share()
        return latest
    }
}

