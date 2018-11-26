//
//  ALMainProtocols.swift
//  Quiet
//
//  Created by Alvaro on 20/11/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit

protocol ALMainViewProtocol {
    var presenter: (ALMainPresenterProtocol & UICollectionViewDelegate & UICollectionViewDataSource)! {get set}
}

protocol ALMainPresenterProtocol {
    var view: ALMainViewProtocol! {get set}
    var wireframe: ALMainViewWireframeProtocol! {get set}
    
    func viewDidLoad()
}

protocol ALMainViewWireframeProtocol {
    var view: (ALMainViewProtocol & UIViewController)! {get set}
    
    func presentMainViewInWindow(_ window: UIWindow)
    func goTo(_ section: Section)
}

enum Section: String {
    case SleepCast = "SleepCast"
    case Breathe = "Breathe"
    case Sleep = "Sleep"
    case Landscapes = "Landscapes"
    case ASMR = "ASMR"
    case YogaStretch = "Yoga Stretch"
}
