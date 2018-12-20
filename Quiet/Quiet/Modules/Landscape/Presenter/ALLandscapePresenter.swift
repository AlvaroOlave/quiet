//
//  ALLandscapePresenter.swift
//  Quiet
//
//  Created by Alvaro on 20/12/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

class ALLandscapePresenter: ALLandscapePresenterProtocol {
    var view: ALLandscapeViewProtocol!
    var wireframe: ALLandscapeWireframeProtocol!
    
    var elem: ALLandscapeElem!
    
    func viewDidLoad() {
        
    }
    
    func backButtonPressed() { wireframe.dismiss() }
    
    
}
