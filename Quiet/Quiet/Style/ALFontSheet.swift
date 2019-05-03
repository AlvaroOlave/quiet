//
//  FontSheet.swift
//  Gluco
//
//  Created by Alvaro on 10/1/17.
//  Copyright © 2017 Health. All rights reserved.
//

import UIKit

let MINI_FONT_SIZE : Float = 14.0
let SMALL_FONT_SIZE : Float = 16.0
let NORMAL_FONT_SIZE : Float = 18.0
let BIG_FONT_SIZE : Float = 22.0
let MEGA_FONT_SIZE : Float = 26.0

struct FontSheet {
    static func FontLightWith(size : Float) -> UIFont {
        return UIFont.systemFont(ofSize: CGFloat(size), weight: UIFont.Weight.light)
    }
    
    static func FontRegularWith(size : Float) -> UIFont {
        return UIFont.systemFont(ofSize: CGFloat(size), weight: UIFont.Weight.regular)
    }
    
    static func FontMediumWith(size : Float) -> UIFont {
        return UIFont.systemFont(ofSize: CGFloat(size), weight: UIFont.Weight.medium)
    }
    
    static func FontBoldWith(size : Float) -> UIFont {
        return UIFont.systemFont(ofSize: CGFloat(size), weight: UIFont.Weight.bold)
    }
    
    static func FontSemiBoldWith(size : Float) -> UIFont! {
        return UIFont.systemFont(ofSize: CGFloat(size), weight: UIFont.Weight.semibold)
    }
}
