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
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    var presenter: (ALMainPresenterProtocol & UICollectionViewDataSource & UICollectionViewDelegate)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
        presenter.viewDidLoad()
    }
    
    func hideTitle(_ hide: Bool) { titleImageView.isHidden = hide }
    
    //MARK:- private methods
    
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
        backgroundImageView.animate(withGIFNamed: "waterfall") { }
        backgroundImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideCollectionView)))
        backgroundImageView.isUserInteractionEnabled = true
        
        titleImageView.image = UIImage(named: "QuietBlackground")
        titleImageView.backgroundColor = CLEAR_COLOR
        titleImageView.contentMode = .scaleAspectFit
    }
    
    @objc func hideCollectionView() {
        collectionViewHeight.constant = (collectionViewHeight.constant == 0) ? 170 : 0
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutSubviews()
        }, completion: nil)
    }
}
