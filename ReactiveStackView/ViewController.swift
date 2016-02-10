//
//  ViewController.swift
//  ReactiveStackView
//
//  Created by Ian Dundas on 08/02/2016.
//  Copyright © 2016 IanDundas. All rights reserved.
//

import UIKit
import ReactiveKit
import ReactiveUIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Input Item:
        let inputStackItem = NSBundle.mainBundle().loadNibNamed("ReactiveInputStackItem", owner: self, options: nil).first as! ReactiveInputStackItem
        stackView.addArrangedSubview(inputStackItem)
        
        // bindings
        inputStackItem.value.map{ Int($0) }.bindTo(viewModel.count)
        
        // Color Item:
        let colorStackItem = NSBundle.mainBundle().loadNibNamed("ReactiveColorStackItem", owner: self, options: nil).first as! ReactiveColorStackItem
        stackView.addArrangedSubview(colorStackItem)

        
        // bindings
        colorStackItem.colorStream.bindTo(viewModel.color)

        
        // View Model Bindings:
        viewModel.color.map(UIColor.inverse).bindTo(inputStackItem.label.rTextColor)
        viewModel.color.bindTo(view.rBackgroundColor)
        
    }
}

class ReactiveInputStackItem: UIView{
    
    @IBOutlet private weak var slider: UISlider!
    @IBOutlet weak var label: UILabel!

    lazy var value: Observable<Float> = self.slider.rValue
}

class ReactiveColorStackItem: UIView{
    
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



