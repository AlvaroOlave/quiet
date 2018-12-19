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
    
    func setImage(_ img: String, title: String)
    func restorePlayButton()
}

protocol ALSleepCastPresenterProtocol {
    var view: ALSleepCastViewProtocol! {get set}
    var wireframe: ALSleepCastViewWireframeProtocol! {get set}
    
    var elem: ALSleepCastElem! {get set}
    
    func viewDidLoad()
    func backButtonPressed()
    func playButtonDidPressed()
    func pauseButtonDidPressed()
    func musicVolume(_ volume: Float)
    func voiceVolume(_ volume: Float)
}

protocol ALSleepCastViewWireframeProtocol {
    var view: (ALSleepCastViewProtocol & UIViewController)! {get set}
    
    func presentSleepCastViewIn(_ view: UIViewController)
    func dismiss()
}
