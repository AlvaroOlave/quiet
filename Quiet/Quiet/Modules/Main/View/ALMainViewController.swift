//
//  ALMainViewController.swift
//  Quiet
//
//  Created by Alvaro on 20/11/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit
import Gifu

class ALMainViewController: UIViewController, ALMainViewProtocol {
    
    @IBOutlet weak var backgroundImageView: GIFImageView!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    var presenter: (ALMainPresenterProtocol & UICollectionViewDataSource & UICollectionViewDelegate)!
    
    override var shouldAutorotate: Bool { return false }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { return .portrait }
    
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
        backgroundImageView.animate(withGIFNamed: "waterfall") {
            print("Ready to animate!")
        }
    }
}
