//
//  ALYogaWireframe.swift
//  Quiet
//
//  Created by Alvaro on 20/12/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit

class ALYogaWireframe: ALYogaWireframeProtocol {
    var view: (UIViewController & ALYogaViewProtocol)!
    
    func presentYogaViewIn(_ fromView: UIViewController) { fromView.present(view, animated: true) }
    func dismiss() { view.dismiss(animated: true) }
}
