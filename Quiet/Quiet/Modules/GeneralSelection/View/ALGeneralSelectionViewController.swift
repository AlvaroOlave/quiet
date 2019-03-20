//
//  ALGeneralSelectionViewController.swift
//  Quiet
//
//  Created by Alvaro on 26/11/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit
import JTMaterialSpinner
import FBAudienceNetwork

class ALGeneralSelectionViewController: ALBaseViewController, ALGeneralSelectionViewProtocol, FBInterstitialAdDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backgroundView : UIView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var backSpinnerView : UIView!
    @IBOutlet weak var shadowSpinnerView : UIView!
    @IBOutlet weak var spinnerView : JTMaterialSpinner!
    
    var interstitialAd: FBInterstitialAd?
    var section: Section!
    
    var presenter: (ALGeneralSelectionPresenterProtocol & UICollectionViewDataSource & UICollectionViewDelegate)!

    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        presenter.viewDidLoad()
        
        interstitialAd = FBInterstitialAd(placementID: "810898249287725_810899832620900")
        interstitialAd?.delegate = self
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureCollectionViewLayout()
    }
    
    override func backButtonPressed() { presenter.backButtonPressed() }
    
    func reloadCollectionView() { collectionView.reloadData() }
    
    func startLoading() {
        spinnerView.beginRefreshing()
        backSpinnerView.alpha = 0.0
        backSpinnerView.isHidden = false
        UIView.animate(withDuration: 0.2) { self.backSpinnerView.alpha = 1.0 }
    }
    
    func stopLoading() {
        backSpinnerView.isHidden = true
        spinnerView.endRefreshing()
    }
    
    func showAd() {
        interstitialAd?.load()
    }
    
    //MARK:- private methods
    
    private func commonInit() {
        configureCollectionView()
        configureLoadingView()
        
        titleLabel.textColor = MERCURY_GREY.withAlphaComponent(0.9)
        titleLabel.text = section.rawValue
        titleLabel.font = FontSheet.FontSemiBoldWith(size: MEGA_FONT_SIZE)
        
        backIcon?.image = UIImage(named: "icCancel")
        view.layer.backgroundColor = WARM_GREY.withAlphaComponent(0.5).cgColor
    
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backButtonPressed)))
        backgroundView.isUserInteractionEnabled = true
        backgroundView.backgroundColor = CLEAR_COLOR
        collectionView.backgroundView = UIView(frame: collectionView.frame)
        collectionView.backgroundView?.isUserInteractionEnabled = true
        collectionView.backgroundView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backButtonPressed)))

    }
    
    private func configureLoadingView() {
        backSpinnerView.backgroundColor = WARM_GREY.withAlphaComponent(0.5)
        
        spinnerView.circleLayer.lineWidth = 2.0
        spinnerView.circleLayer.strokeColor = DARK_SKY_BLUE.cgColor
        spinnerView.animationDuration = 2.5
        
        shadowSpinnerView.layer.cornerRadius = 8.0
        shadowSpinnerView.backgroundColor = MERCURY_GREY.withAlphaComponent(0.9)
        
        backSpinnerView.isHidden = true
    }
    
    private func configureCollectionView() {
        
        collectionView.dataSource = presenter
        collectionView.delegate = presenter
        collectionView.register(UINib(nibName: "ALResourceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ALResourceCollectionViewCell")
    }
    
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
    
    //MARK:- FBInterstitialAdDelegate methods
    
    func interstitialAdDidLoad(_ interstitialAd: FBInterstitialAd) {
        if interstitialAd.isAdValid {
            interstitialAd.show(fromRootViewController: self)
        }
    }
}
