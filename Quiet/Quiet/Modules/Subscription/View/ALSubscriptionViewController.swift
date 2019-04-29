//
//  ALSubscriptionViewController.swift
//  Quiet
//
//  Created by Alvaro on 28/12/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit
import JTMaterialSpinner
import AudioToolbox

class ALSubscriptionViewController: ALBaseViewController, ALSubscriptionViewProtocol {
    var presenter: ALSubscriptionPresenterProtocol!

    @IBOutlet weak var frameView: UIView!
    @IBOutlet weak var quietImageView: UIImageView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var popularLabel: UILabel!
    @IBOutlet weak var weeklyTitle: UILabel!
    @IBOutlet weak var weeklyPrice: UILabel!
    @IBOutlet weak var weeklyDescription: UILabel!
    @IBOutlet weak var weeklyArea: UIView!
    @IBOutlet weak var monthlyTitle: UILabel!
    @IBOutlet weak var monthlyPrice: UILabel!
    @IBOutlet weak var monthlyDescription: UILabel!
    @IBOutlet weak var monthlyArea: UIView!
    @IBOutlet weak var yearlyTitle: UILabel!
    @IBOutlet weak var yearlyPrice: UILabel!
    @IBOutlet weak var yearlyDescription: UILabel!
    @IBOutlet weak var yearlyArea: UIView!
    @IBOutlet var promoDescriptions: [UILabel]!
    @IBOutlet weak var backSpinnerView : UIView!
    @IBOutlet weak var shadowSpinnerView : UIView!
    @IBOutlet weak var spinnerView : JTMaterialSpinner!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var descriptionTextHeight: NSLayoutConstraint!
    
    var prices = ("-", "-", "-") {
        didSet {
            setDescriptionText(priceWeek: prices.0, priceMonth: prices.1, priceYear: prices.2)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commonInit()
        presenter.viewDidLoad()
    }
    
    override func backButtonPressed() { presenter.backButtonPressed() }
    
    //MARK:- viewConfiguration
    
    private func commonInit() {
        configureView()
        configureButtons()
        configurePromoLabels()
        configureLabels()
        configureLoadingView()
    }
    
    private func configureView() {
        backIcon?.image = UIImage(named: "icCancel")
        frameView.backgroundColor = WHITE
    }
    
    private func configureLabels() {
        subtitleLabel.text = "Get premium!"
        subtitleLabel.textColor = WHITE
        subtitleLabel.font = FontSheet.FontBoldWith(size: MEGA_FONT_SIZE)
        
        setDescriptionText(priceWeek: prices.0, priceMonth: prices.1, priceYear: prices.2)
    }
    
    private func configureButtons() {
        
        weeklyTitle.text = "Weekly"
        weeklyTitle.font = FontSheet.FontRegularWith(size: BIG_FONT_SIZE)
        weeklyTitle.textColor = WHITE
        
        weeklyPrice.text = "-"
        weeklyPrice.font = FontSheet.FontRegularWith(size: BIG_FONT_SIZE)
        weeklyPrice.textColor = WHITE
        
        weeklyDescription.text = "billed weekly"
        weeklyDescription.font = FontSheet.FontLightWith(size: SMALL_FONT_SIZE)
        weeklyDescription.textColor = WHITE

        weeklyArea.layer.cornerRadius = 8.0
        weeklyArea.backgroundColor = GREENY_BLUE
        weeklyArea.layer.borderWidth = 1.0
        weeklyArea.layer.borderColor = WHITE.withAlphaComponent(0.5).cgColor
        weeklyArea.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(weekDidPressed)))
        weeklyArea.isUserInteractionEnabled = true
        
        monthlyTitle.text = "Monthly"
        monthlyTitle.font = FontSheet.FontRegularWith(size: BIG_FONT_SIZE)
        monthlyTitle.textColor = WHITE
        
        monthlyPrice.text = "-"
        monthlyPrice.font = FontSheet.FontRegularWith(size: BIG_FONT_SIZE)
        monthlyPrice.textColor = WHITE
        
        monthlyDescription.text = "billed monthly"
        monthlyDescription.font = FontSheet.FontLightWith(size: SMALL_FONT_SIZE)
        monthlyDescription.textColor = WHITE
        
        monthlyArea.layer.cornerRadius = 8.0
        monthlyArea.backgroundColor = BLUE_BLUE
        monthlyArea.layer.borderWidth = 4.0
        monthlyArea.layer.borderColor = LIGHT_ORANGE.cgColor
        monthlyArea.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(monthDidPressed)))
        monthlyArea.isUserInteractionEnabled = true
        
        popularLabel.text = "  Most Popular  "
        popularLabel.font = FontSheet.FontRegularWith(size: NORMAL_FONT_SIZE)
        popularLabel.layer.cornerRadius = popularLabel.bounds.height / 2.0
        popularLabel.backgroundColor = LIGHT_ORANGE
        popularLabel.textColor = WHITE
        popularLabel.clipsToBounds = true
        
        yearlyTitle.text = "Yearly"
        yearlyTitle.font = FontSheet.FontRegularWith(size: BIG_FONT_SIZE)
        yearlyTitle.textColor = WHITE
        
        yearlyPrice.text = "-"
        yearlyPrice.font = FontSheet.FontRegularWith(size: BIG_FONT_SIZE)
        yearlyPrice.textColor = WHITE
        
        yearlyDescription.text = "billed yearly"
        yearlyDescription.font = FontSheet.FontLightWith(size: SMALL_FONT_SIZE)
        yearlyDescription.textColor = WHITE
        
        yearlyArea.layer.cornerRadius = 8.0
        yearlyArea.backgroundColor = WINE_RED
        yearlyArea.layer.borderWidth = 1.0
        yearlyArea.layer.borderColor = WHITE.withAlphaComponent(0.5).cgColor
        yearlyArea.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(yearDidPressed)))
        yearlyArea.isUserInteractionEnabled = true
    }
    
    private func configurePromoLabels() {
        let descriptions = ["●  Unlock Yoga Trainings.",
                            "●  Breathe without Limits.",
                            "●  Access to all content.",
                            "●  Remove Ads."]
        promoDescriptions.enumerated().forEach {
            $1.text = descriptions[$0]
            $1.textColor = WHITE
            $1.font = FontSheet.FontRegularWith(size: BIG_FONT_SIZE)
        }
    }
    
    private func setDescriptionText(priceWeek: String, priceMonth: String, priceYear: String) {
        
        let normalAttributes = [NSAttributedString.Key.font: FontSheet.FontRegularWith(size: SMALLEST_FONT_SIZE - 4),
                                NSAttributedString.Key.foregroundColor: WHITE ]
        //Subscription for a period of (%@/week), (%@/month) or (%@/year).
        let description = NSMutableAttributedString(string: String(format: "Payment will be charged to iTunes Account at confirmation of purchase.Subscription automatically renews unless auto-renew is turned off at least 24-hours before the end of the current period.Account will be charged for renewal within 24-hours prior to the end of the current period with (%@/week), (%@/month) or (%@/year) .Subscriptions may be managed by the user and auto-renewal may be turned off by going to the user's Account Settings after purchase.", priceWeek, priceMonth, priceYear, priceWeek, priceMonth, priceYear), attributes: normalAttributes)
        let attributes = [NSAttributedString.Key.font: FontSheet.FontMediumWith(size: SMALLEST_FONT_SIZE - 4),
                          NSAttributedString.Key.foregroundColor: WHITE ]
        
        description.append(NSMutableAttributedString(string: " Contact us ", attributes: attributes))
        description.append(NSMutableAttributedString(string: "https://supercoolmobileapps.wixsite.com/website", attributes: normalAttributes))
        description.append(NSMutableAttributedString(string: " Privacy policy ", attributes: attributes))
        description.append(NSMutableAttributedString(string: "https://supercoolmobileapps.wixsite.com/website/privacy-policy", attributes: normalAttributes))
        
        descriptionTextView.attributedText = description
        descriptionTextHeight.constant = height(for: description.string, width: descriptionTextView.bounds.width, font: FontSheet.FontRegularWith(size: SMALLEST_FONT_SIZE - 4))
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
    
    private func vibrate() { UIImpactFeedbackGenerator(style: .light).impactOccurred() }
    
    @objc func weekDidPressed() { vibrate(); presenter.weekDidPressed() }
    @objc func monthDidPressed() { vibrate(); presenter.monthDidPressed() }
    @objc func yearDidPressed() { vibrate(); presenter.yearDidPressed() }
    
    //MARK:-
    
    func setWeeklySubscriptionPrice(_ price: String) { weeklyPrice.text = price; prices.0 = price }
    func setMonthlySubscriptionPrice(_ price: String) { monthlyPrice.text = price; prices.1 = price }
    func setYearlySubscriptionPrice(_ price: String) { yearlyPrice.text = price; prices.2 = price }
    
    func showLoading() {
        spinnerView.beginRefreshing()
        backSpinnerView.alpha = 0.0
        backSpinnerView.isHidden = false
        UIView.animate(withDuration: 0.2) { self.backSpinnerView.alpha = 1.0 }
    }
    
    func hideLoading() {
        backSpinnerView.isHidden = true
        spinnerView.endRefreshing()
    }
    
    func height(for text: String, width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintRect,
                                          options: .usesLineFragmentOrigin,
                                          attributes: [NSAttributedString.Key.font: font],
                                          context: nil)
        
        return ceil(boundingBox.height) + 20
    }
}
