//
//  ALMainViewController.swift
//  Quiet
//
//  Created by Alvaro on 20/11/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit

class ALMainViewController: UIViewController, ALMainViewProtocol {
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    var presenter: (ALMainPresenterProtocol & UICollectionViewDataSource & UICollectionViewDelegate)!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commonInit()
        presenter.viewDidLoad()
    }

    private func commonInit() {
        configureCollectionViewLayout()
        mainCollectionView.dataSource = presenter
        mainCollectionView.delegate = presenter
        mainCollectionView.register(UINib(nibName: "ALMainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ALMainCollectionViewCell")
    }
    
    func configureCollectionViewLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.itemSize = CGSize(width: mainCollectionView.bounds.width - 20,
                                     height: 150)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 10
        mainCollectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        mainCollectionView.collectionViewLayout = flowLayout
        mainCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
}
