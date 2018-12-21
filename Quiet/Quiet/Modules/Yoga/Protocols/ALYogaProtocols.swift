//
//  ALYogaProtocols.swift
//  Quiet
//
//  Created by Alvaro on 20/12/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit

protocol ALYogaViewProtocol {
    var presenter: ALYogaPresenterProtocol! {get set}
    
    func setVideo(_ videoURL: URL)
}

protocol ALYogaPresenterProtocol {
    var view: ALYogaViewProtocol! {get set}
    var wireframe: ALYogaWireframeProtocol! {get set}
    
    var elem: ALGeneralElem! {get set}
    
    func viewDidLoad()
    func backButtonPressed()
}

protocol ALYogaWireframeProtocol {
    var view: (ALYogaViewProtocol & UIViewController)! {get set}
    
    func presentYogaViewIn(_ view: UIViewController)
    func dismiss()
}
