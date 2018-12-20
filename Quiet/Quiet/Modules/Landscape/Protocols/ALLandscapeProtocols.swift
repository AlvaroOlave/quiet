//
//  ALLandscapeProtocols.swift
//  Quiet
//
//  Created by Alvaro on 20/12/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit

protocol ALLandscapeViewProtocol {
    var presenter: ALLandscapePresenterProtocol! {get set}
    
}

protocol ALLandscapePresenterProtocol {
    var view: ALLandscapeViewProtocol! {get set}
    var wireframe: ALLandscapeWireframeProtocol! {get set}
    
    var elem: ALLandscapeElem! {get set}
    
    func viewDidLoad()
    func backButtonPressed()
}

protocol ALLandscapeWireframeProtocol {
    var view: (ALLandscapeViewProtocol & UIViewController)! {get set}
    
    func presentLandscapeViewIn(_ view: UIViewController)
    func dismiss()
}
