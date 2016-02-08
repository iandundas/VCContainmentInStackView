//
//  ViewController.swift
//  ReactiveStackView
//
//  Created by Ian Dundas on 08/02/2016.
//  Copyright © 2016 IanDundas. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let item = NSBundle.mainBundle().loadNibNamed("ReactiveInputStackItem", owner: self, options: nil).first as! UIView
        item.backgroundColor = UIColor.randomColor()
        stackView.addArrangedSubview(item)
    }
    
}

class ReactiveInputStackItem: UIView{
    
    @IBOutlet weak var slider: UISlider!
}

extension UIColor{
    static func randomColor()->UIColor{
        return UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 0.5)
    }
}
