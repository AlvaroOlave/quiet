//
//  ALMainWireframe.swift
//  Quiet
//
//  Created by Alvaro on 20/11/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit

class ALMainWireframe: ALMainViewWireframeProtocol, ALGeneralSelectionViewWireframeDelegate {
    
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
        var breatheWireframe = breatheFactory()
        breatheWireframe.delegate = self
        breatheWireframe.presentBreatheViewIn(view)
    }
    
    private func presentGeneralSelection(_ section: Section) {
        var wireframe = generalSelectionFactory(of: section)
        wireframe.delegate = self
        wireframe.presentGeneralSelectionViewIn(view)
    }
    
    //MARK:- ALGeneralSelectionViewWireframeDelegate methods
    
    func viewDidDissapear() { view.hideTitle(false); view.presenter.viewDidAppear() }
}
