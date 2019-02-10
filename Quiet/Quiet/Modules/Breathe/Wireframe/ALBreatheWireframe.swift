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
    
    var delegate: ALGeneralSelectionViewWireframeDelegate?
    
    func presentBreatheViewIn(_ fromView: UIViewController) { fromView.present(view, animated: true) }
    
    func presentSubscriptionInterface() {
        let wireframe = subscriptionFactory(with: .Normal)
        wireframe.presentSubscriptionOverViewIn(view)
    }
    
    func dismiss() { delegate?.viewDidDissapear(); view.dismiss(animated: true) }
}
