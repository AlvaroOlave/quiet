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
        window.rootViewController?.view.alpha = 0.0
        UIView.transition(with: window,
                          duration: 0.2,
                          options: [.transitionCrossDissolve, .curveEaseInOut],
                          animations: {
                            window.rootViewController?.view.alpha = 1.0
        })
    }
}
