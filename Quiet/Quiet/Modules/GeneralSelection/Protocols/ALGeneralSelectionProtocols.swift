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
    
    var section: Section! {get set}
    
    func reloadCollectionView()
}

protocol ALGeneralSelectionPresenterProtocol {
    var view: ALGeneralSelectionViewProtocol! {get set}
    var interactor: ALGeneralSelectionInteractorProtocol! {get set}
    var wireframe: ALGeneralSelectionViewWireframeProtocol! {get set}
    
    func viewDidLoad()
    func viewWillDisappear()
    func backButtonPressed()
}

protocol ALGeneralSelectionInteractorProtocol {
    var dataManager: ALGeneralSelectionDataManagerProtocol! {get set}
    var section: Section! {get set}
    
    func getResourcesList(completion: @escaping ([ALSectionElem]) -> Void)
    func getCompleteInfoOf(_ elem: ALSectionElem, completion: @escaping (ALBaseElem) -> Void)
    func dismiss()
}

protocol ALGeneralSelectionDataManagerProtocol {
    func getResourcesListOf(_ section: Section, completion: @escaping ([Any]?) -> Void)
    func getResource(_ name: String, completion: @escaping (Data?) -> Void)
    func getResourceURL(_ name: String, completion: @escaping (Data?) -> Void)
    func dismiss()
}



protocol ALGeneralSelectionViewWireframeProtocol {
    var view: (ALGeneralSelectionViewProtocol & UIViewController)! {get set}
    
    func presentGeneralSelectionViewIn(_ view: UIViewController)
    func presentSectionElem(_ elem: ALBaseElem)
    func dismiss()
}
