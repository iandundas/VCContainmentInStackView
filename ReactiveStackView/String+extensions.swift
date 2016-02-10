//
//  String.swift
//  ReactiveStackView
//
//  Created by Ian Dundas on 10/02/2016.
//  Copyright © 2016 IanDundas. All rights reserved.
//

import Foundation
// Returns a random Emoji 🌿
extension String{
    func randomEmoji()->String{
        let range = 0x1F601...0x1F64F
        let ascii = range.startIndex + Int(arc4random_uniform(UInt32(range.count)))
        let emoji = String(UnicodeScalar(ascii))
        return emoji
    }
}
