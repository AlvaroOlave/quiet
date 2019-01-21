//
//  ALBreathePresenter.swift
//  Quiet
//
//  Created by Alvaro on 20/11/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//
import Foundation

class ALBreathePresenter: ALBreathePresenterProtocol {
    var view: ALBreatheViewProtocol!
    var wireframe: ALBreatheViewWireframeProtocol!
    
    func viewDidLoad() {
        
    }
    
    func presentSubscriptionInterface() { wireframe.presentSubscriptionInterface() }
    
    func getLastBreatheTime() -> Double {
        let lastTime = UserDefaults.standard.double(forKey: "al_last_breathe_time")
        return lastTime == 0 ? 30.0 : lastTime
    }
    
    func setLastBreatheTime(_ time: Double) {
        UserDefaults.standard.set(time, forKey: "al_last_breathe_time")
    }
    
    func backButtonPressed() { wireframe.dismiss() }
}
