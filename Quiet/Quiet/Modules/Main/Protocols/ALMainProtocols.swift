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
    
    func setAdvice(_ advice: String)
    func hideTitle(_ hide: Bool)
    func setBackgroung(_ data: Data)
}

protocol ALMainPresenterProtocol {
    var view: ALMainViewProtocol! {get set}
    var interactor: ALMainInteractorProtocol! {get set}
    var wireframe: ALMainViewWireframeProtocol! {get set}
    
    func viewDidLoad()
    func viewDidAppear()
    func viewWillDisappear()
}

protocol ALMainInteractorProtocol {
    var dataManager: ALMainDataManagerProtocol! {get set}
    
    func getAllResourceLists()
    func getDailyAdvise(_ completion: @escaping (String?) -> Void)
    func getNextBackground(_ completion: @escaping (Data?, Data?) -> Void)
}

protocol ALMainDataManagerProtocol {
    func getAllResourceLists()
    func getAllDailyAdvices(_ completion: @escaping ([String]?) -> Void)
    func getAllAvailableBackgrounds(_ completion: @escaping ([Any]?) -> Void)
    func downloadbackground(_ name: String, _ completion: @escaping (Bool) -> Void)
    func getLocalFile(_ named: String, _ completion: @escaping (Data?) -> Void)
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
