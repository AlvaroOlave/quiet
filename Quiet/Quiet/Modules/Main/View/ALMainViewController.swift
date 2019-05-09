//
//  ALMainViewController.swift
//  Quiet
//
//  Created by Alvaro on 20/11/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit
import Gifu
import UserNotifications
import UserNotificationsUI

class ALMainViewController: UIViewController, ALMainViewProtocol {
    
    @IBOutlet weak var backgroundImageView: GIFImageView!
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var promoImage: UIImageView!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var adviceFrame: UIView!
    @IBOutlet weak var gradientView: ALGradientView!
    @IBOutlet weak var happySunImage: UIImageView!
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var adviceViewTop: NSLayoutConstraint!
    
    var presenter: (ALMainPresenterProtocol & UICollectionViewDataSource & UICollectionViewDelegate)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
        presenter.viewDidLoad()
        UNUserNotificationCenter.current().delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureCollectionViewLayout()
    }
    
    func setAdvice(_ advice: String) {
        
        let attrs = [ NSAttributedString.Key.font : FontSheet.FontRegularWith(size: NORMAL_FONT_SIZE),
                  NSAttributedString.Key.foregroundColor : BROWNISH_GREY]
        let str = NSMutableAttributedString(string: advice, attributes: attrs)
        
        adviceLabel.attributedText = str
        adviceFrame.alpha = 0.0
        adviceFrame.isHidden = false
        UIView.animate(withDuration: 0.1, delay: 0.5, options: .curveEaseInOut, animations: {
            self.adviceFrame.alpha = 1.0
        }, completion: nil)
    }
    
    func showPromoIcon() { promoImage.isHidden = false }
    func hideTitle(_ hide: Bool) { titleImageView.isHidden = hide; adviceFrame.isHidden = hide }
    func setBackgroung(_ data: Data) { backgroundImageView.animate(withGIFData: data) }
    
    //MARK:- private methods
    
    private func commonInit() {
//        configureCollectionViewLayout()
        configureBackgroundImage()
        configureAdviseLabel()
        configurePromoImage()
        mainCollectionView.dataSource = presenter
        mainCollectionView.delegate = presenter
        mainCollectionView.register(UINib(nibName: "ALMainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ALMainCollectionViewCell")
    }
    
    private func configureCollectionViewLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        #if SLEEPCAST
        flowLayout.itemSize = CGSize(width: view.frame.width, height: 150)
        mainCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        #elseif QUIET
        flowLayout.itemSize = CGSize(width: 85, height: 150)
        mainCollectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        #endif
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        
        mainCollectionView.collectionViewLayout = flowLayout
    }
    
    private func configureBackgroundImage() {
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideCollectionView)))
        backgroundImageView.isUserInteractionEnabled = true
        
        titleImageView.image = UIImage(named: "QuietBlackground")
        titleImageView.backgroundColor = CLEAR_COLOR
        titleImageView.contentMode = .scaleAspectFit
    }
    
    private func configurePromoImage() {
        promoImage.image = UIImage(named: "promo")?.withRenderingMode(.alwaysTemplate)
        promoImage.tintColor = WHITE
        promoImage.backgroundColor = MERCURY_GREY.withAlphaComponent(0.9)
        promoImage.layer.cornerRadius = (promoImage.bounds.height) / 2.0
        promoImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(promoButtonDidPressed)))
        promoImage.isUserInteractionEnabled = true
        promoImage.isHidden = true
    }
    
    private func configureAdviseLabel() {
        adviceFrame.layer.cornerRadius = 16.0
        adviceFrame.layer.borderColor = WARM_GREY.withAlphaComponent(0.7).cgColor
        adviceFrame.backgroundColor = WHITE_TWO.withAlphaComponent(0.8)
        adviceLabel.textColor = BROWNISH_GREY
        adviceLabel.font = FontSheet.FontLightWith(size: NORMAL_FONT_SIZE)
        adviceFrame.isHidden = true
        happySunImage.image = UIImage(named: "happySun")?.withRenderingMode(.alwaysTemplate)
        happySunImage.tintColor = BROWNISH_GREY
    }
    
    @objc func promoButtonDidPressed() { presenter.promoDidPressed() }
    
    @objc func hideCollectionView() {
        collectionViewHeight.constant = (collectionViewHeight.constant == 0) ? 170 : 0
        
        adviceViewTop.constant = adviceViewTop.constant == 60 ? -(adviceFrame.frame.origin.y + adviceFrame.frame.height) : 60
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutSubviews()
        }, completion: nil)
    }
}

class ALGradientView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        configureGradient()
    }
    
    private func configureGradient() {
        
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.name = "QUOBackgroundSmallGradient"
        
        gradient.colors = [CLEAR_COLOR.cgColor,
                           BLACK.cgColor]
        
        gradient.locations = [0.0 , 1.1]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        gradient.frame = bounds
        
        layer.sublayers?.forEach({
            if $0.name == "QUOBackgroundSmallGradient" { $0.removeFromSuperlayer() }
        })
        layer.insertSublayer(gradient, at: 0)
    }
}

extension ALMainViewController: UNUserNotificationCenterDelegate {
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier.hasPrefix("promo") {
            presenter.promoDidPressed()
        }
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler( [.alert,.sound,.badge])
    }
}
