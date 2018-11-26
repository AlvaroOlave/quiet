//
//  ALGeneralSelectionViewController.swift
//  Quiet
//
//  Created by Alvaro on 26/11/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit

class ALGeneralSelectionViewController: UIViewController, ALGeneralSelectionViewProtocol {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var backIcon: UIImageView!
    
    var presenter: (ALGeneralSelectionPresenterProtocol & UICollectionViewDataSource & UICollectionViewDelegate)!

    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        presenter.viewDidLoad()
    }
    
    func reloadCollectionView() { collectionView.reloadData() }
    
    private func commonInit() {
        configureCollectionViewLayout()
        collectionView.dataSource = presenter
        collectionView.delegate = presenter
        collectionView.register(UINib(nibName: "ALResourceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ALResourceCollectionViewCell")
        configureBackButton()
    }
    
    private func configureBackButton() {
        backView.backgroundColor = MERCURY_GREY
        backView.layer.cornerRadius = backView.bounds.height / 2.0
        backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backButtonPressed)))
        backView.isUserInteractionEnabled = true
        
        backIcon.image = UIImage(named: "icBackArrow")
    }
    
    @objc func backButtonPressed() { presenter.backButtonPressed() }
    
    private func configureCollectionViewLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.itemSize = CGSize(width: collectionView.bounds.width - 20,
                                     height: 150)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 10
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.collectionViewLayout = flowLayout
    }
}
