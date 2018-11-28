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

func generalSelectionFactory(of section: Section) -> ALGeneralSelectionViewWireframeProtocol {
    let wireframe = ALGeneralSelectionWireframe()

    wireframe.view = ALGeneralSelectionViewController(nibName: "ALGeneralSelectionViewController", bundle: nil)
    wireframe.view.section = section
    
    wireframe.view.presenter = ALGeneralSelectionPresenter()
    wireframe.view.presenter.view = wireframe.view
    wireframe.view.presenter.wireframe = wireframe
    wireframe.view.presenter.interactor = ALGeneralSelectionInteractor()
    
    wireframe.view.presenter.interactor.section = section
    wireframe.view.presenter.interactor.dataManager = ALGeneralSelectionDataManager()
    
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

func sleepFactory() -> ALSleepViewWireframeProtocol {
    let wireframe = ALSleepWireframe()
    
    wireframe.view = ALSleepViewController(nibName: "ALSleepViewController", bundle: nil)
    
    wireframe.view.presenter = ALSleepPresenter()
    wireframe.view.presenter.view = wireframe.view
    wireframe.view.presenter.wireframe = wireframe
    
    return wireframe
}
