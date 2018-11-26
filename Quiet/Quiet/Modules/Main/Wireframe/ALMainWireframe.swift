//
//  ALMainWireframe.swift
//  Quiet
//
//  Created by Alvaro on 20/11/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit

class ALMainWireframe: ALMainViewWireframeProtocol {
    
    var view: (UIViewController & ALMainViewProtocol)!
    
    func presentMainViewInWindow(_ window: UIWindow) {
        window.rootViewController = view
    }
    
    func goTo(_ section: Section) {
        switch section {
        case .SleepCast:
            break
        case .Breathe:
            presentBreatheSection()
            break
        case .Sleep:
            break
        case .Landscapes:
            break
        case .ASMR:
            break
        case .YogaStretch:
            break
        }
    }
    
    //MARK:- privateMethods
    
    private func presentBreatheSection() {
        let breatheWireframe = breatheFactory()
        breatheWireframe.presentBreatheViewIn(view)
    }
}
