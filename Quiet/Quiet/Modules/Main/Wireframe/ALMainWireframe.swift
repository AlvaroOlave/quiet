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
        case .Breathe:
            presentBreatheSection()
            break
        default:
            presentGeneralSelection(section)
        }
    }
    
    //MARK:- privateMethods
    
    private func presentBreatheSection() {
        let breatheWireframe = breatheFactory()
        breatheWireframe.presentBreatheViewIn(view)
    }
    
    private func presentGeneralSelection(_ section: Section) {
        let wireframe = generalSelectionFactory(of: section)
        wireframe.presentGeneralSelectionViewIn(view)
    }
}
