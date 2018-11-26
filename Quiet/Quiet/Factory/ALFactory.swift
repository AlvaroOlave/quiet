//
//  ALFactory.swift
//  Quiet
//
//  Created by Alvaro on 20/11/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit

func mainFactory() -> ALMainViewWireframeProtocol {
    let wireframe = ALMainWireframe()
    
    wireframe.view = ALMainViewController(nibName: "ALMainViewController", bundle: nil)
    
    wireframe.view.presenter = ALMainPresenter()
    wireframe.view.presenter.view = wireframe.view
    wireframe.view.presenter.wireframe = wireframe
    
    return wireframe
}

func breatheFactory() -> ALBreatheViewWireframeProtocol {
    let wireframe = ALBreatheWireframe()
    
    wireframe.view = ALBreatheViewController(nibName: "ALBreatheViewController", bundle: nil)
    
    wireframe.view.presenter = ALBreathePresenter()
    wireframe.view.presenter.view = wireframe.view
    wireframe.view.presenter.wireframe = wireframe
    
    return wireframe
}
