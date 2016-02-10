//
//  UIColor+extensions.swift
//  ReactiveStackView
//
//  Created by Ian Dundas on 10/02/2016.
//  Copyright © 2016 IanDundas. All rights reserved.
//

import UIKit

extension UIColor{
    static func randomColor()->UIColor{
        return UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 0.5)
    }
    static func inverse(color: UIColor) -> UIColor {
        var r:CGFloat = 0.0; var g:CGFloat = 0.0; var b:CGFloat = 0.0; var a:CGFloat = 0.0;
        if color.getRed(&r, green: &g, blue: &b, alpha: &a) {
            return UIColor(red: 1.0-r, green: 1.0 - g, blue: 1.0 - b, alpha: a)
        }
        return color
    }
}
