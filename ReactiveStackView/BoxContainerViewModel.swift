//
//  BoxContainerViewModel.swift
//  ReactiveStackView
//
//  Created by Ian Dundas on 11/02/2016.
//  Copyright © 2016 IanDundas. All rights reserved.
//

import Foundation
import ReactiveKit

enum BoxAction {
    case Add(Int)
    case Remove(Int)
}

class BoxContainerViewModel {
    
    let boxesCount = Observable<Int>(0)
    let addBoxes: Stream<Int>
    let removeBoxes: Stream<Int>
    
    private let mutations: Stream<BoxAction?>
    
    init(startingCount: Int){
        boxesCount.next(startingCount)
        
        mutations = boxesCount.zipPrevious().map { (previousValue:Int?, newValue:Int) -> BoxAction? in
            guard let previousValue = previousValue else { return .Add(newValue) }
            guard previousValue != newValue else {return nil}
            
            if newValue > previousValue{
                return .Add(newValue - previousValue)
            }
            else {
                return .Remove(previousValue - newValue)
            }
        }
        
        addBoxes = mutations.ignoreNil().filter(filterAddActions).map(extractActionCount)
        removeBoxes = mutations.ignoreNil().filter(filterRemoveActions).map(extractActionCount)
    }
}



/*  global filters: */
let filterAddActions = { (action: BoxAction) -> Bool in
    if case .Add(_) = action {
        return true
    }
    return false
}
let filterRemoveActions = { (action: BoxAction) -> Bool in
    if case .Remove(_) = action {
        return true
    }
    return false
}

let extractActionCount = { (action: BoxAction) -> Int in
    switch (action){
    case .Add(let count):
        return count
    case .Remove(let count):
        return count
    }
}
