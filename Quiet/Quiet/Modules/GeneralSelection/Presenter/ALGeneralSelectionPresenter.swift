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
    func viewWillDisappear() { interactor.dismiss() }
    func backButtonPressed() {  view.stopLoading(); wireframe.dismiss() }
    
    
    //MARK:- private methods
    
    private func getResourcesList() {
        view.startLoading()
        interactor.getResourcesList { [weak self] elems in self?.resourceList = elems; self?.view.stopLoading() }
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
        if resourceList[indexPath.row].isPremium {
            wireframe.presentSubscriptionInterface()
        } else {
            view.startLoading()
            interactor.getCompleteInfoOf(resourceList[indexPath.row]) { [weak self] elem in
                self?.view.stopLoading()
                self?.wireframe.presentSectionElem(elem)
            }
        }
//        view.showAd()
//        wireframe.presentSubscriptionInterface()
    }
    
    //MARK:- UICollectionViewDelegate methods

}
