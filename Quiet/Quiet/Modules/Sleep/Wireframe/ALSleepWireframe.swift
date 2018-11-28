//
//  ALSleepWireframe.swift
//  Quiet
//
//  Created by Alvaro on 27/11/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit

class ALSleepWireframe: ALSleepViewWireframeProtocol {
    var view: (UIViewController & ALSleepViewProtocol)!
    
    func presentSleepViewIn(_ fromView: UIViewController) { fromView.present(view, animated: true) }
    func dismiss() { view.dismiss(animated: true) }
}
