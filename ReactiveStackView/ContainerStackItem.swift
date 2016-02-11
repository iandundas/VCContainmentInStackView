//
//  ViewContainerStackItem.swift
//  ReactiveStackView
//
//  Created by Ian Dundas on 10/02/2016.
//  Copyright © 2016 IanDundas. All rights reserved.
//

import UIKit
import ReactiveKit

class ContainerStackItem: UIView {
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    let childViewController: UIViewController
    
    let allowedWidth = Observable<CGFloat>(UIViewNoIntrinsicMetric)
    let currentHeight = Observable<CGFloat>(300)
    
    init(childViewController: UIViewController, parentViewController: UIViewController){
        self.childViewController = childViewController
        
        super.init(frame: CGRect.zero)
        
        parentViewController.addChildViewController(childViewController)
        addSubview(childViewController.view)
        childViewController.didMoveToParentViewController(parentViewController)
        
        combineLatest(allowedWidth.distinct(), currentHeight.distinct()).skip(1).observe(on: ImmediateOnMainExecutionContext) { [weak self] _,_ in
            guard let strongSelf = self else {return}

            UIView.animateWithDuration(0.2, animations: {
                strongSelf.invalidateIntrinsicContentSize()
                strongSelf.superview?.layoutIfNeeded()
            })
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        childViewController.view.frame.size = frame.size
    }
    
    override func intrinsicContentSize() -> CGSize {
        return CGSize(width: allowedWidth.value, height: currentHeight.value)
    }
}
