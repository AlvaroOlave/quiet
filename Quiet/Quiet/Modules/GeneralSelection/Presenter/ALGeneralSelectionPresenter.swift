//
//  ALGeneralSelectionPresenter.swift
//  Quiet
//
//  Created by Alvaro on 26/11/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit

class ALGeneralSelectionPresenter: NSObject, ALGeneralSelectionPresenterProtocol, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var view: ALGeneralSelectionViewProtocol!
    var interactor: ALGeneralSelectionInteractorProtocol!
    var wireframe: ALGeneralSelectionViewWireframeProtocol!
    
    var resourceList = [ALSectionElem]() {
        didSet { view.reloadCollectionView() }
    }
    
    func viewDidLoad() { getResourcesList() }
    func backButtonPressed() { wireframe.dismiss() }
    
    //MARK:- private methods
    
    private func getResourcesList() {
        interactor.getResourcesList { [weak self] elems in self?.resourceList = elems }
    }
    
    //MARK:- UICollectionViewDataSource methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resourceList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ALResourceCollectionViewCell", for: indexPath) as! ALResourceCollectionViewCell
        
        let elem = resourceList[indexPath.row]
        cell.setTitle(elem.title, backgroundImg: elem.imgURL, isPremium: elem.isPremium)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        wireframe.presentSectionElem(resourceList[indexPath.row])
    }
    
    //MARK:- UICollectionViewDelegate methods

}
