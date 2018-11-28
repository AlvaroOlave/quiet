//
//  ALSleepPresenter.swift
//  Quiet
//
//  Created by Alvaro on 27/11/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

class ALSleepPresenter: ALSleepPresenterProtocol {
    var view: ALSleepViewProtocol!
    
    var wireframe: ALSleepViewWireframeProtocol!
    
    func viewDidLoad() {
        
    }
    
    func backButtonPressed() { wireframe.dismiss() }
}
