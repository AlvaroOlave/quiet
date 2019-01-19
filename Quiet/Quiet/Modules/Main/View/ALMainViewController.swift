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
    @IBOutlet weak var adviceFrame: UIView!
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var adviceViewTop: NSLayoutConstraint!
    
    var presenter: (ALMainPresenterProtocol & UICollectionViewDataSource & UICollectionViewDelegate)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
        presenter.viewDidLoad()
    }
    
    func setAdvice(_ advice: String) {
        
        var attrs : [NSAttributedString.Key : Any] = [ NSAttributedString.Key.font : FontSheet.FontBoldWith(size: BIG_FONT_SIZE),
                                                       NSAttributedString.Key.foregroundColor : WHITE,
                                                       NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue]
        let str = NSMutableAttributedString(string: "Daily advice\n\n", attributes: attrs)
        
        attrs = [ NSAttributedString.Key.font : FontSheet.FontRegularWith(size: NORMAL_FONT_SIZE),
                  NSAttributedString.Key.foregroundColor : WHITE]
        
        str.append(NSAttributedString(string: advice, attributes: attrs))
        
        adviceLabel.attributedText = str
    }
    
    func hideTitle(_ hide: Bool) { titleImageView.isHidden = hide }
    
    //MARK:- private methods
    
    private func commonInit() {
        configureCollectionViewLayout()
        configureBackgroundImage()
        configureAdviseLabel()
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
    
    private func configureAdviseLabel() {
        adviceFrame.layer.cornerRadius = 16.0
        adviceFrame.layer.borderColor = WARM_GREY.withAlphaComponent(0.7).cgColor
        adviceFrame.layer.borderWidth = 2.0
        adviceFrame.backgroundColor = MERCURY_GREY.withAlphaComponent(0.8)
        adviceLabel.textColor = WHITE
        adviceLabel.font = FontSheet.FontLightWith(size: NORMAL_FONT_SIZE)
    }
    
    @objc func hideCollectionView() {
        collectionViewHeight.constant = (collectionViewHeight.constant == 0) ? 170 : 0
        adviceViewTop.constant = adviceViewTop.constant == 60 ? -view.frame.height : 60
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutSubviews()
        }, completion: nil)
    }
}
