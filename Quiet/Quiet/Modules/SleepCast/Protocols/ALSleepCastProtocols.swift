//
//  ALSleepCastCastProtocols.swift
//  Quiet
//
//  Created by Alvaro on 14/12/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit

protocol ALSleepCastViewProtocol {
    var presenter: ALSleepCastPresenterProtocol! {get set}
}

protocol ALSleepCastPresenterProtocol {
    var view: ALSleepCastViewProtocol! {get set}
    var wireframe: ALSleepCastViewWireframeProtocol! {get set}
    
    func viewDidLoad()
    func backButtonPressed()
}

protocol ALSleepCastViewWireframeProtocol {
    var view: (ALSleepCastViewProtocol & UIViewController)! {get set}
    
    func presentSleepCastViewIn(_ view: UIViewController)
    func dismiss()
}
