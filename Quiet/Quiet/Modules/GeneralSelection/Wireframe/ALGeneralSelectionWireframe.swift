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
    
    func presentSectionElem(_ elem: ALBaseElem) {
        switch elem.baseSection.kindOfResource {
        case .SleepCast:
            presentSleepCastInterface(elem as! ALSleepCastElem)
        case .Sleep:
            presentSleepInterface(elem as! ALGeneralElem)
        case .Landscapes:
            presentLandscapeInterface(elem as! ALLandscapeElem)
        default:
            break
        }
    }
    
    private func presentSleepInterface(_ elem: ALGeneralElem) {
        let wireframe = sleepFactory(with: elem)
        wireframe.presentSleepViewIn(view)
    }
    
    private func presentSleepCastInterface(_ elem: ALSleepCastElem) {
        let wireframe = sleepCastFactory(with: elem)
        wireframe.presentSleepCastViewIn(view)
    }
    
    private func presentLandscapeInterface(_ elem: ALLandscapeElem) {
        let wireframe = landscapeFactory(with: elem)
        wireframe.presentLandscapeViewIn(view)
    }
}
