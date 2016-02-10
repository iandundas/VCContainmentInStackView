//
//  ReactiveKit+extensions.swift
//  ReactiveStackView
//
//  Created by Ian Dundas on 10/02/2016.
//  Copyright © 2016 IanDundas. All rights reserved.
//

import Foundation
import ReactiveKit

public func merge<S: StreamType>(streams: [S]) -> Stream<S.Event> {
    return Stream { observer in
        let compositeDisposable = CompositeDisposable()
        for stream in streams {
            compositeDisposable += stream.observe(on: nil) { event in
                observer(event)
            }
        }
        return compositeDisposable
    }
}

extension StreamType{
    
    func log() {
        self.observe(on: ImmediateExecutionContext, observer: { print($0) })
    }
    
    func log(name name: String) {
        self.observe(on: ImmediateExecutionContext, observer: { print("\(name): \($0)") })
    }
    
}
