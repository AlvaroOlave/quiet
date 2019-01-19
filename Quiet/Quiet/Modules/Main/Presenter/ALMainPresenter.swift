//
//  ALMainPresenter.swift
//  Quiet
//
//  Created by Alvaro on 20/11/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//
import UIKit

class ALMainPresenter: NSObject, ALMainPresenterProtocol, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var view: ALMainViewProtocol!
    var interactor: ALMainInteractorProtocol!
    var wireframe: ALMainViewWireframeProtocol!
    
    let cells: [Section] = [.SleepCast, .Breathe, .Sleep, .Landscapes, .ASMR, .YogaStretch]
    let cellIcons: [String] = ["sleepCastIcon", "breatheIcon", "sleepIcon", "ladscapeIcon", "asmrIcon", "yogaIcon"]
    
    func viewDidLoad() {
        interactor.getAllResourceLists()
        interactor.getDailyAdvise { (advice) in
            if let adv = advice { self.view.setAdvice(adv) }
        }
    }
    
    //MARK:- UICollectionViewDataSource methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ALMainCollectionViewCell", for: indexPath) as! ALMainCollectionViewCell
        
        cell.setCellTitle(cells[indexPath.row].rawValue, background: nil, icon: UIImage(named: cellIcons[indexPath.row]))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        view.hideTitle(true)
        wireframe.goTo(cells[indexPath.row])
    }
    
    //MARK:- UICollectionViewDelegate methods
    
}
