//
//  ALYogaPresenter.swift
//  Quiet
//
//  Created by Alvaro on 20/12/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

class ALYogaPresenter: ALYogaPresenterProtocol {
    var view: ALYogaViewProtocol!
    var wireframe: ALYogaWireframeProtocol!
    
    var elem: ALGeneralElem!
    
    func viewDidLoad() {
        
    }
    
    func backButtonPressed() { wireframe.dismiss() }
}
