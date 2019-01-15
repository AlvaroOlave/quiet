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
    var delegate: ALGeneralSelectionViewWireframeDelegate?
    
    func presentGeneralSelectionViewIn(_ fromView: UIViewController) {
        fromView.definesPresentationContext = true
        view.modalTransitionStyle = .crossDissolve
        view.modalPresentationStyle = .overCurrentContext
        fromView.present(view, animated: true)
    }
    func dismiss() { self.delegate?.viewDidDissapear(); view.dismiss(animated: true) }
    
    func presentSectionElem(_ elem: ALBaseElem) {
        switch elem.baseSection.kindOfResource {
        case .SleepCast:
            presentSleepCastInterface(elem as! ALSleepCastElem)
        case .Sleep:
            presentSleepInterface(elem as! ALGeneralElem)
        case .Landscapes:
            presentLandscapeInterface(elem as! ALLandscapeElem)
        case .ASMR:
            presentASMRInterface(elem as! ALGeneralElem)
        case .YogaStretch:
            presentYogaStretchInterface(elem as! ALGeneralElem)
        default:
            break
        }
    }
    
    func presentSubscriptionInterface() {
        let wireframe = subscriptionFactory(with: .Normal)
        wireframe.presentSubscriptionViewIn(view)
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
    
    private func presentASMRInterface(_ elem: ALGeneralElem) {
        let wireframe = asmrFactory(with: elem)
        wireframe.presentASMRViewIn(view)
    }
    
    private func presentYogaStretchInterface(_ elem: ALGeneralElem) {
        let wireframe = yogaFactory(with: elem)
        wireframe.presentYogaViewIn(view)
    }
}
