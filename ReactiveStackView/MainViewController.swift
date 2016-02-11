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
    
    lazy var heightInputStackItem: SliderStackItem = NSBundle.mainBundle().loadNibNamed("SliderStackItem", owner: self, options: nil).first as! SliderStackItem
    lazy var countInputStackItem: SliderStackItem = NSBundle.mainBundle().loadNibNamed("SliderStackItem", owner: self, options: nil).first as! SliderStackItem
    lazy var colorStackItem: ColorStackItem = NSBundle.mainBundle().loadNibNamed("ColorStackItem", owner: self, options: nil).first as! ColorStackItem
    
    lazy var boxesViewController = UIStoryboard(name: "BoxContainer", bundle: nil).instantiateInitialViewController() as! BoxContainerViewController
    
    lazy var boxesContainerStackItem: ContainerStackItem = {
        self.boxesViewController.viewModel = BoxContainerViewModel(startingCount: 4)
        return ContainerStackItem(childViewController: self.boxesViewController, parentViewController: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupControls()
        
        stackView.addArrangedSubview(heightInputStackItem)
        stackView.addArrangedSubview(countInputStackItem)
        stackView.addArrangedSubview(colorStackItem)
        stackView.addArrangedSubview(boxesContainerStackItem)

        setupItemCountBindings()
        setupColorBindings()
        setupHeightBindings()
        
        setupObservers()
    }
    
    private func setupControls(){
        heightInputStackItem.setMin(35, max: 400)
        heightInputStackItem.label.text = "Allowed Height:"
        
        countInputStackItem.label.text = "Items:"
        countInputStackItem.setMin(0, max: 100)
        
        boxesContainerStackItem.layer.borderColor = UIColor.blackColor().CGColor
        boxesContainerStackItem.layer.borderWidth = 1
    }
    

    private func setupItemCountBindings(){
        countInputStackItem.value
            .map { Int($0) }
            .bindTo(viewModel.count)
        
        viewModel.count
            .bindTo(boxesViewController.viewModel.boxesCount)
        
        viewModel.count
            .map { "Items (\(String(format: "%03d", $0))):" }
            .bindTo(countInputStackItem.label.rText)
    }
    
    private func setupColorBindings(){
        colorStackItem.colorStream
            .bindTo(viewModel.color)
        
        viewModel.color
            .map(UIColor.inverse)
            .bindTo(countInputStackItem.label.rTextColor)
        
        viewModel.color
            .map(UIColor.inverse)
            .bindTo(heightInputStackItem.label.rTextColor)
        
        viewModel.color
            .bindTo(view.rBackgroundColor)
    }
    
    private func setupHeightBindings(){
        heightInputStackItem.value
            .map {CGFloat(floor($0))}
            .bindTo(viewModel.desiredHeight)

        let validHeightStream = viewModel.allowedHeight.filter({_, allowed in allowed}).map{$0.0} // filter only valid values
        
        validHeightStream.bindTo(boxesContainerStackItem.currentHeight)

        validHeightStream
            .map { "Allowed Height: \(String(format: "%0.f", $0))pt" }
            .bindTo(heightInputStackItem.label.rText)
    }
    
    private func setupObservers(){
//        viewModel.count.log(name: "Count")
    }
}


