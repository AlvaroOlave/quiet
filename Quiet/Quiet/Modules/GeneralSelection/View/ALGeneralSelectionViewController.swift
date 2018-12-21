//
//  ALGeneralSelectionViewController.swift
//  Quiet
//
//  Created by Alvaro on 26/11/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit

class ALGeneralSelectionViewController: ALBaseViewController, ALGeneralSelectionViewProtocol {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var section: Section!
    
    var presenter: (ALGeneralSelectionPresenterProtocol & UICollectionViewDataSource & UICollectionViewDelegate)!

    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        presenter.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear()
    }
    
    func reloadCollectionView() { collectionView.reloadData() }
    
    private func commonInit() {
        configureCollectionViewLayout()
        collectionView.dataSource = presenter
        collectionView.delegate = presenter
        collectionView.register(UINib(nibName: "ALResourceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ALResourceCollectionViewCell")
        
        backIcon?.image = UIImage(named: "icCancel")
        
        view.layer.backgroundColor = WARM_GREY.withAlphaComponent(0.5).cgColor
    }
    
    override func backButtonPressed() { presenter.backButtonPressed() }
    
    private func configureCollectionViewLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.itemSize = cellFrameForSection()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 10
        collectionView.contentInset = contentInsets()
        collectionView.collectionViewLayout = flowLayout
    }
    
    private func cellFrameForSection() -> CGSize {
        switch section {
        case .SleepCast?:
            return CGSize(width: collectionView.bounds.width - 20, height: 150)
        case .Landscapes?:
            return CGSize(width: collectionView.bounds.width - 20, height: 150)
        case .Sleep?:
            return CGSize(width: (collectionView.bounds.width / 3.0) - 20, height: 150)
        case .ASMR?:
            return CGSize(width: (collectionView.bounds.width / 3.0) - 20, height: 150)
        case .YogaStretch?:
            return CGSize(width: collectionView.bounds.width - 20, height: 200)
        default:
            return CGSize(width: collectionView.bounds.width - 20, height: 150)
        }
    }
    
    private func contentInsets() -> UIEdgeInsets {
        let horizontalEdge = CGFloat((section == .Sleep || section == .ASMR) ? 20 : 0)
        
        return UIEdgeInsets(top: 50, left: horizontalEdge, bottom: 20, right: horizontalEdge)
    }
}
