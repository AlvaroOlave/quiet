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
    
    #if SLEEPCAST
    wireframe.view = ALMainViewController(nibName: "ALSimpleMainViewController", bundle: nil)
    #elseif QUIET
    wireframe.view = ALMainViewController(nibName: "ALMainViewController", bundle: nil)
    #endif
    
    wireframe.view.presenter = ALMainPresenter()
    wireframe.view.presenter.view = wireframe.view
    wireframe.view.presenter.interactor = ALMainInteractor()
    wireframe.view.presenter.interactor.dataManager = ALMainDataManager()
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
    wireframe.view.presenter.dataManager = ALBreatheDataManager()
    wireframe.view.presenter.wireframe = wireframe
    
    return wireframe
}

func sleepFactory(with elem: ALGeneralElem) -> ALSleepViewWireframeProtocol {
    let wireframe = ALSleepWireframe()
    
    wireframe.view = ALSleepViewController(nibName: "ALSleepViewController", bundle: nil)
    
    wireframe.view.presenter = ALSleepPresenter()
    wireframe.view.presenter.view = wireframe.view
    wireframe.view.presenter.wireframe = wireframe
    wireframe.view.presenter.elem = elem
    
    return wireframe
}

func sleepCastFactory(with elem: ALSleepCastElem) -> ALSleepCastWireframe {
    let wireframe = ALSleepCastWireframe()
    
    wireframe.view = ALSleepCastViewController(nibName: "ALSleepCastViewController", bundle: nil)
    
    wireframe.view.presenter = ALSleepCastPresenter()
    wireframe.view.presenter.view = wireframe.view
    wireframe.view.presenter.wireframe = wireframe
    wireframe.view.presenter.elem = elem
    
    return wireframe
}

func landscapeFactory(with elem: ALLandscapeElem) -> ALLandscapeWireframeProtocol {
    let wireframe = ALLandscapeWireframe()
    
    wireframe.view = ALLandscapeViewController(nibName: "ALLandscapeViewController", bundle: nil)
    
    wireframe.view.presenter = ALLandscapePresenter()
    wireframe.view.presenter.view = wireframe.view
    wireframe.view.presenter.wireframe = wireframe
    wireframe.view.presenter.elem = elem
    
    return wireframe
}

func asmrFactory(with elem: ALGeneralElem) -> ALASMRWireframeProtocol {
    let wireframe = ALASMRWireframe()
    
    wireframe.view = ALASMRViewController(nibName: "ALASMRViewController", bundle: nil)
    
    wireframe.view.presenter = ALASMRPresenter()
    wireframe.view.presenter.view = wireframe.view
    wireframe.view.presenter.wireframe = wireframe
    wireframe.view.presenter.elem = elem
    
    return wireframe
}

func yogaFactory(with elem: ALGeneralElem) -> ALYogaWireframeProtocol {
    let wireframe = ALYogaWireframe()
    
    wireframe.view = ALYogaViewController(nibName: "ALYogaViewController", bundle: nil)
    
    wireframe.view.presenter = ALYogaPresenter()
    wireframe.view.presenter.view = wireframe.view
    wireframe.view.presenter.wireframe = wireframe
    wireframe.view.presenter.elem = elem
    
    return wireframe
}

func subscriptionFactory(with mode: SubscriptionMode) -> ALSubscriptionWireframeProtocol {
    let wireframe = ALSubscriptionWireframe()
    
    wireframe.view = ALNewSubscriptionViewController(nibName: "ALNewSubscriptionViewController", bundle: nil)
    
    wireframe.view.presenter = ALSubscriptionPresenter()
    wireframe.view.presenter.view = wireframe.view
    wireframe.view.presenter.wireframe = wireframe
    wireframe.view.presenter.mode = mode
    
    return wireframe
}
