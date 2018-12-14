//
//  ALSleepCastCastPresenter.swift
//  Quiet
//
//  Created by Alvaro on 14/12/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

class ALSleepCastPresenter: ALSleepCastPresenterProtocol {
    var view: ALSleepCastViewProtocol!
    
    var wireframe: ALSleepCastViewWireframeProtocol!
    
    func viewDidLoad() {
        
    }
    
    func backButtonPressed() { wireframe.dismiss() }
}
