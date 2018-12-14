//
//  ALSleepCastCastWireframe.swift
//  Quiet
//
//  Created by Alvaro on 14/12/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit

class ALSleepCastWireframe: ALSleepCastViewWireframeProtocol {
    var view: (UIViewController & ALSleepCastViewProtocol)!
    
    func presentSleepCastViewIn(_ fromView: UIViewController) {
        fromView.definesPresentationContext = true
        view.modalTransitionStyle = .crossDissolve
        view.modalPresentationStyle = .overCurrentContext
        fromView.present(view, animated: true)
        
    }
    func dismiss() { view.dismiss(animated: true) }
}
