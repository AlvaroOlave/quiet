//
//  ALASMRPresenter.swift
//  Quiet
//
//  Created by Alvaro on 20/12/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

class ALASMRPresenter: ALASMRPresenterProtocol {
    var view: ALASMRViewProtocol!
    var wireframe: ALASMRWireframeProtocol!
    
    var elem: ALGeneralElem!
    
    func viewDidLoad() {
        
    }
    
    func backButtonPressed() { wireframe.dismiss() }
}
