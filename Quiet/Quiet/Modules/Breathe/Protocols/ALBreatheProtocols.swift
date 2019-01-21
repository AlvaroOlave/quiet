//
//  ALBreatheProtocols.swift
//  Quiet
//
//  Created by Alvaro on 20/11/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit

protocol ALBreatheViewProtocol {
    var presenter: ALBreathePresenterProtocol! {get set}
}

protocol ALBreathePresenterProtocol {
    var view: ALBreatheViewProtocol! {get set}
    var wireframe: ALBreatheViewWireframeProtocol! {get set}
    
    func viewDidLoad()
    func backButtonPressed()
    func presentSubscriptionInterface()
    func getLastBreatheTime() -> Double
    func setLastBreatheTime(_ time: Double)
}

protocol ALBreatheViewWireframeProtocol {
    var view: (ALBreatheViewProtocol & UIViewController)! {get set}
    
    func presentBreatheViewIn(_ view: UIViewController)
    func presentSubscriptionInterface()
    func dismiss()
}
