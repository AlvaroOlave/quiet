//
//  ALMainViewController.swift
//  Quiet
//
//  Created by Alvaro on 20/11/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit

class ALMainViewController: UIViewController, ALMainViewProtocol {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    var presenter: (ALMainPresenterProtocol & UICollectionViewDataSource & UICollectionViewDelegate)!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commonInit()
        presenter.viewDidLoad()
    }

    private func commonInit() {
        configureCollectionViewLayout()
        configureBackgroundImage()
        mainCollectionView.dataSource = presenter
        mainCollectionView.delegate = presenter
        mainCollectionView.register(UINib(nibName: "ALMainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ALMainCollectionViewCell")
    }
    
    private func configureCollectionViewLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.itemSize = CGSize(width: 85, height: 150)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        mainCollectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        mainCollectionView.collectionViewLayout = flowLayout
    }
    
    private func configureBackgroundImage() {
        backgroundImageView.image = UIImage.animatedImageNamed("waterfall", duration: 0.0)
    }
}
