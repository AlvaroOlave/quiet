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
    
    func viewDidLoad() {
        
    }
    
    //MARK:- UICollectionViewDataSource methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    //MARK:- UICollectionViewDelegate methods

}
