//
//  ALSubscriptionWireframe.swift
//  Quiet
//
//  Created by Alvaro on 28/12/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit

class ALSubscriptionWireframe: ALSubscriptionWireframeProtocol {
    var view: (UIViewController & ALSubscriptionViewProtocol)!
    var delegate: ALSubscriptionWireframeDelegate?
    
    func presentSubscriptionViewIn(_ fromView: UIViewController) { fromView.present(view, animated: true) }
    func presentSubscriptionOverViewIn(_ fromView: UIViewController) {
        fromView.present(view, animated: true)
    }
    func dismiss() { view.dismiss(animated: true) }
}
