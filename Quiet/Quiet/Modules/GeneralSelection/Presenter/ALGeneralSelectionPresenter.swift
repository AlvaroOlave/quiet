//
//  ALGeneralSelectionPresenter.swift
//  Quiet
//
//  Created by Alvaro on 26/11/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit

class ALGeneralSelectionPresenter: NSObject, ALGeneralSelectionPresenterProtocol, ALSubscriptionWireframeDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var view: ALGeneralSelectionViewProtocol!
    var interactor: ALGeneralSelectionInteractorProtocol!
    var wireframe: ALGeneralSelectionViewWireframeProtocol!
    
    var resourceList = [ALSectionElem]() {
        didSet { view.reloadCollectionView() }
    }
    
    var waitingResource: ALSectionElem? = nil
    
    func viewDidLoad() { getResourcesList() }
    func viewWillDisappear() { interactor.dismiss() }
    func backButtonPressed() {  view.stopLoading(); wireframe.dismiss() }
    func adDidCompleted() { openResource(waitingResource) }
    
    //MARK:- private methods
    
    private func getResourcesList() {
        view.startLoading()
        interactor.getResourcesList { [weak self] elems in self?.filterIfPremium(elems); self?.view.stopLoading() }
    }
    
    private func filterIfPremium(_ list: [ALSectionElem]) {
        if ALUserTokenManager.shared.currentUser.isPremium() {
            self.resourceList = list.map({
                var copy = $0
                copy.isPremium = false
                return copy
            })
        } else {
            self.resourceList = list
        }
    }
    
    private func openResource(_ resource: ALSectionElem?) {
        if let res = resource {
            view.startLoading()
            interactor.getCompleteInfoOf(res) { [weak self] elem in
                self?.view.stopLoading()
                self?.waitingResource = nil
                self?.wireframe.presentSectionElem(elem)
            }
        }
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
            if ALUserTokenManager.shared.currentUser.isPremium() {
                openResource(resourceList[indexPath.row])
            } else {
                openResource(resourceList[indexPath.row])
//                waitingResource = resourceList[indexPath.row]
//                view.showAd()
            }
        }
    }
    
    //MARK:- UICollectionViewDelegate methods
    
    //MARK:- ALSubscriptionWireframeDelegate methods
    
    func subscribed() { filterIfPremium(resourceList) }
}
