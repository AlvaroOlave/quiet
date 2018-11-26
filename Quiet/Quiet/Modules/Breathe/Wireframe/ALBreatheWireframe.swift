//
//  ALBreatheWireframe.swift
//  Quiet
//
//  Created by Alvaro on 20/11/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit

class ALBreatheWireframe: ALBreatheViewWireframeProtocol {
    
    var view: (UIViewController & ALBreatheViewProtocol)!
    
    func presentBreatheViewIn(_ fromView: UIViewController) {
        fromView.present(view, animated: true)
    }
    
    func dismiss() { view.dismiss(animated: true) }
}
