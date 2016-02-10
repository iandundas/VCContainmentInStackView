//
//  BoxContainerViewController.swift
//  ReactiveStackView
//
//  Created by Ian Dundas on 10/02/2016.
//  Copyright © 2016 IanDundas. All rights reserved.
//

import UIKit
import ReactiveKit

enum BoxAction {
    case Add(Int)
    case Remove(Int)
}

class BoxContainerViewModel {
    let boxesCount = Observable<Int>(0)
    let mutations: Stream<BoxAction?>
    
    init(startingCount: Int){
        boxesCount.next(startingCount)
        
        mutations = boxesCount.zipPrevious().map { (previousValue:Int?, newValue:Int) -> BoxAction? in
            guard let previousValue = previousValue else { return .Add(newValue) }
            guard previousValue != newValue else {return nil}
            
            print("value: \(newValue)")
            if newValue > previousValue{
                return .Add(newValue - previousValue)
            }
            else {
                return .Remove(previousValue - newValue)
            }
        }
    }
}

class BoxContainerViewController: UIViewController{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    
    var viewModel = BoxContainerViewModel(startingCount: 50)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        viewModel.mutations.ignoreNil().observe { [weak self] mutation in
            guard let strongSelf = self else {return}
            
            switch mutation{
            case .Add(let count):
                print("Add: \(count)")
                for _ in 0...count {
                    strongSelf.stackView.addArrangedSubview(Box())
                }
                
            case .Remove(let count):
                print("Remove: \(count)")
                for _ in 0...count {
                    guard let lastView = strongSelf.stackView.arrangedSubviews.last else {break}
                    strongSelf.stackView.removeArrangedSubview(lastView)
                    lastView.removeFromSuperview()
                }
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


