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
    
    func setSoundList()
    func selectElem(_ elem: String)
}

protocol ALBreathePresenterProtocol {
    var view: ALBreatheViewProtocol! {get set}
    var dataManager: ALBreatheDataManagerProtocol! {get set}
    var wireframe: ALBreatheViewWireframeProtocol! {get set}
    
    func viewDidLoad()
    func backButtonPressed()
    func presentSubscriptionInterface()
    func getLastBreatheTime() -> Double
    func setLastBreatheTime(_ time: Double)
    func playAudio()
    func stopAudio()
}

protocol ALBreatheDataManagerProtocol {
    func getResourcesList(completion: @escaping ([Any]?) -> Void)
    func getResource(_ name: String, completion: @escaping (Data?) -> Void)
    func dismiss()
}

protocol ALBreatheViewWireframeProtocol {
    var view: (ALBreatheViewProtocol & UIViewController)! {get set}
    
    var delegate: ALGeneralSelectionViewWireframeDelegate? {get set}
    
    func presentBreatheViewIn(_ view: UIViewController)
    func presentSubscriptionInterface()
    func dismiss()
}
