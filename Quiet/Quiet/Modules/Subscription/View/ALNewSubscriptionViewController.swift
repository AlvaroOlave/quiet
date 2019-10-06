//
//  ALNewSubscriptionViewController.swift
//  Quiet
//
//  Created by Alvaro on 06/10/2019.
//  Copyright © 2019 surflabapps. All rights reserved.
//

import UIKit
import Gifu
import JTMaterialSpinner

class ALNewSubscriptionViewController: ALBaseViewController, ALSubscriptionViewProtocol {
    var presenter: ALSubscriptionPresenterProtocol!
    
    @IBOutlet weak var backgroundImageView: GIFImageView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var subtitleLabel: UILabel?
    @IBOutlet weak var promoLabel: UILabel?
    @IBOutlet weak var normalPriceLabel: UILabel?
    @IBOutlet weak var subscribeButton: UIButton?
    @IBOutlet weak var restoreButton: UIButton?
    @IBOutlet weak var tosTextView: UITextView?
    
    @IBOutlet weak var backSpinnerView : UIView?
    @IBOutlet weak var shadowSpinnerView : UIView?
    @IBOutlet weak var spinnerView : JTMaterialSpinner?
    
    var prices = ("-", "-", "-") {
        didSet {
            setDescriptionText(priceWeek: prices.0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        commonInit()
        presenter.viewDidLoad()
    }
    
    override func backButtonPressed() { presenter.backButtonPressed() }

    private func commonInit() {
        configureLabels()
        configureButtons()
        configureLoadingView()
        setDescriptionText(priceWeek: prices.0)
    }
    
    private func configureLabels() {
        promoLabel?.textColor = #colorLiteral(red: 0.3294117647, green: 0.4941176471, blue: 0.9647058824, alpha: 1)
        normalPriceLabel?.textColor = #colorLiteral(red: 0.3294117647, green: 0.4941176471, blue: 0.9647058824, alpha: 1)
        
        titleLabel?.font = FontSheet.FontBoldWith(size: 32.0)
        titleLabel?.textColor = BROWNISH_GREY
        
        subtitleLabel?.font = FontSheet.FontLightWith(size: 24.0)
        subtitleLabel?.textColor = BROWNISH_GREY
    }
    
    private func configureButtons() {
        subscribeButton?.backgroundColor = #colorLiteral(red: 0.3294117647, green: 0.4941176471, blue: 0.9647058824, alpha: 1)
        subscribeButton?.layer.cornerRadius = 8.0
        subscribeButton?.addTarget(self, action: #selector(weekDidPressed), for: .touchUpInside)
        backIcon?.image = UIImage(named: "icCancel")
        
        restoreButton?.setTitle("restore", for: .normal)
        restoreButton?.titleLabel?.textColor = WARM_GREY
        restoreButton?.backgroundColor = CLEAR_COLOR
        restoreButton?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(restoreDidPressed)))
    }
    
    private func vibrate() { UIImpactFeedbackGenerator(style: .light).impactOccurred() }
    
    private func setDescriptionText(priceWeek: String) {
        
        let normalAttributes = [NSAttributedString.Key.font: FontSheet.FontRegularWith(size: MINI_FONT_SIZE - 4),
                                NSAttributedString.Key.foregroundColor: WARM_GREY ]
        //Subscription for a period of (%@/week), (%@/month) or (%@/year).
        let description = NSMutableAttributedString(string: String(format: "Payment will be charged to iTunes Account at confirmation of purchase.Subscription automatically renews unless auto-renew is turned off at least 24-hours before the end of the current period.Account will be charged for renewal within 24-hours prior to the end of the current period with (%@/week) .Subscriptions may be managed by the user and auto-renewal may be turned off by going to the user's Account Settings after purchase.", priceWeek, priceWeek), attributes: normalAttributes)
        let attributes = [NSAttributedString.Key.font: FontSheet.FontMediumWith(size: MINI_FONT_SIZE - 4),
                          NSAttributedString.Key.foregroundColor: WARM_GREY ]
        
        description.append(NSMutableAttributedString(string: " Contact us ", attributes: attributes))
        description.append(NSMutableAttributedString(string: "https://supercoolmobileapps.wixsite.com/website", attributes: normalAttributes))
        description.append(NSMutableAttributedString(string: " Privacy policy ", attributes: attributes))
        description.append(NSMutableAttributedString(string: "https://supercoolmobileapps.wixsite.com/website/privacy-policy", attributes: normalAttributes))
        
        tosTextView?.attributedText = description
        
        normalPriceLabel?.text = String(format: "Then %@ per week.", priceWeek)
//        tosTextView?.constant = height(for: description.string, width: descriptionTextView.bounds.width, font: FontSheet.FontRegularWith(size: MINI_FONT_SIZE - 4))
    }
    
    private func configureLoadingView() {
        backSpinnerView?.backgroundColor = WARM_GREY.withAlphaComponent(0.5)
        
        spinnerView?.circleLayer.lineWidth = 2.0
        spinnerView?.circleLayer.strokeColor = DARK_SKY_BLUE.cgColor
        spinnerView?.animationDuration = 2.5
        
        shadowSpinnerView?.layer.cornerRadius = 8.0
        shadowSpinnerView?.backgroundColor = MERCURY_GREY.withAlphaComponent(0.9)
        
        backSpinnerView?.isHidden = true
    }
    
    func setWeeklySubscriptionPrice(_ price: String) { prices.0 = price }
    func setMonthlySubscriptionPrice(_ price: String) { }
    func setYearlySubscriptionPrice(_ price: String) { }
    func setBackgroungGIF(_ data: Data?) {
        guard let data = data else { return }
        backgroundImageView?.animate(withGIFData: data)
    }
    
    func showLoading() {
        spinnerView?.beginRefreshing()
        backSpinnerView?.alpha = 0.0
        backSpinnerView?.isHidden = false
        UIView.animate(withDuration: 0.2) { self.backSpinnerView?.alpha = 1.0 }
    }
    
    func hideLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.backSpinnerView?.isHidden = true
            self?.spinnerView?.endRefreshing()
        }
    }
    
    @objc private func weekDidPressed() { vibrate(); presenter.weekDidPressed() }
    @objc private func restoreDidPressed() { vibrate(); presenter.restoreDidPressed() }
}
