//
//  ALASMRProtocols.swift
//  Quiet
//
//  Created by Alvaro on 20/12/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit

protocol ALASMRViewProtocol {
    var presenter: ALASMRPresenterProtocol! {get set}
    
}

protocol ALASMRPresenterProtocol {
    var view: ALASMRViewProtocol! {get set}
    var wireframe: ALASMRWireframeProtocol! {get set}
    
    var elem: ALGeneralElem! {get set}
    
    func viewDidLoad()
    func backButtonPressed()
}

protocol ALASMRWireframeProtocol {
    var view: (ALASMRViewProtocol & UIViewController)! {get set}
    
    func presentASMRViewIn(_ view: UIViewController)
    func dismiss()
}
