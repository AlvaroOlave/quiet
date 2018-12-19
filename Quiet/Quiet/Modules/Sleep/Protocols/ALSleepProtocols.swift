//
//  ALSleepProtocols.swift
//  Quiet
//
//  Created by Alvaro on 27/11/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit

protocol ALSleepViewProtocol {
    var presenter: ALSleepPresenterProtocol! {get set}
    
    func setImage(_ img: String, title: String)
}

protocol ALSleepPresenterProtocol {
    var view: ALSleepViewProtocol! {get set}
    var wireframe: ALSleepViewWireframeProtocol! {get set}
    
    var elem: ALGeneralElem! {get set}
    
    func viewDidLoad()
    func backButtonPressed()
    func playButtonDidPressed()
    func pauseButtonDidPressed()
    func loopSeconds(_ secs: Double)
}

protocol ALSleepViewWireframeProtocol {
    var view: (ALSleepViewProtocol & UIViewController)! {get set}
    
    func presentSleepViewIn(_ view: UIViewController)
    func dismiss()
}
