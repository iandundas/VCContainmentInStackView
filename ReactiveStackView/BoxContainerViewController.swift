//
//  BoxContainerViewController.swift
//  ReactiveStackView
//
//  Created by Ian Dundas on 10/02/2016.
//  Copyright © 2016 IanDundas. All rights reserved.
//

import UIKit
import ReactiveKit

class BoxContainerViewController: UIViewController{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    
    var viewModel = BoxContainerViewModel(startingCount: 50)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        viewModel.addBoxes.observe { [weak self] count in
            guard let strongSelf = self else {return}
            for _ in 0...count {
                strongSelf.stackView.addArrangedSubview(Box())
            }
        }
        
        viewModel.removeBoxes.observe { [weak self] count in
            guard let strongSelf = self else {return}
            for _ in 0...count {
                guard let lastView = strongSelf.stackView.arrangedSubviews.last else {break}
                strongSelf.stackView.removeArrangedSubview(lastView)
                lastView.removeFromSuperview()
            }
        }
    }
}



class Box: UIView{
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(frame: CGRect){
        super.init(frame: frame)
        
        backgroundColor = UIColor.randomColor()
    }
    
    override func intrinsicContentSize() -> CGSize {
        return CGSize(width: UIViewNoIntrinsicMetric, height: 35)
    }
}


