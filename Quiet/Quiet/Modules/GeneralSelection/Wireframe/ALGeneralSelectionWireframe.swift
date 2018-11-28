//
//  ALGeneralSelectionWireframe.swift
//  Quiet
//
//  Created by Alvaro on 26/11/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit

class ALGeneralSelectionWireframe: ALGeneralSelectionViewWireframeProtocol {
    var view: (UIViewController & ALGeneralSelectionViewProtocol)!
    
    func presentGeneralSelectionViewIn(_ fromView: UIViewController) { fromView.present(view, animated: true) }
    func dismiss() { view.dismiss(animated: true) }
    
    func presentSectionElem(_ elem: ALSectionElem) {
        switch elem.kindOfResource {
        case .Sleep:
            presentSleepInterface()
        default:
            break
        }
    }
    
    private func presentSleepInterface() {
        let wireframe = sleepFactory()
        wireframe.presentSleepViewIn(view)
    }
}
