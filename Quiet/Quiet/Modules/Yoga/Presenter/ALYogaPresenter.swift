//
//  ALYogaPresenter.swift
//  Quiet
//
//  Created by Alvaro on 20/12/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import Foundation

class ALYogaPresenter: ALYogaPresenterProtocol {
    var view: ALYogaViewProtocol!
    var wireframe: ALYogaWireframeProtocol!
    
    var elem: ALGeneralElem!
    
    func viewDidLoad() {
        
        if let data = elem.resource, let url = URL(dataRepresentation: data, relativeTo: nil) { view.setVideo(url) }
    }
    
    func backButtonPressed() { wireframe.dismiss() }
}
