//
//  ALGeneralSelectionProtocols.swift
//  Quiet
//
//  Created by Alvaro on 26/11/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit

protocol ALGeneralSelectionViewProtocol {
    var presenter: (ALGeneralSelectionPresenterProtocol & UICollectionViewDelegate & UICollectionViewDataSource)! {get set}
}

protocol ALGeneralSelectionPresenterProtocol {
    var view: ALGeneralSelectionViewProtocol! {get set}
    var interactor: ALGeneralSelectionInteractorProtocol! {get set}
    var wireframe: ALGeneralSelectionViewWireframeProtocol! {get set}
    
    func viewDidLoad()
}

protocol ALGeneralSelectionInteractorProtocol {
    var dataManager: ALGeneralSelectionDataManagerProtocol! {get set}
    var section: Section! {get set}
}

protocol ALGeneralSelectionDataManagerProtocol {
    
}



protocol ALGeneralSelectionViewWireframeProtocol {
    var view: (ALGeneralSelectionViewProtocol & UIViewController)! {get set}
    
    func presentGeneralSelectionViewIn(_ view: UIViewController)
    func dismiss()
}
