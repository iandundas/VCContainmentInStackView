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

class MainViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    
    let viewModel = MainViewModel()
    
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



