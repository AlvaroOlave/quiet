//
//  ALSubscriptionViewController.swift
//  Quiet
//
//  Created by Alvaro on 28/12/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit
import JTMaterialSpinner

class ALSubscriptionViewController: ALBaseViewController, ALSubscriptionViewProtocol {
    var presenter: ALSubscriptionPresenterProtocol!

    @IBOutlet weak var frameView: UIView!
    @IBOutlet weak var crownImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var weeklyTitle: UILabel!
    @IBOutlet weak var weeklyPrice: UILabel!
    @IBOutlet weak var weeklyPeriod: UILabel!
    @IBOutlet weak var weeklyDescription: UILabel!
    @IBOutlet weak var weeklyArea: UIView!
    @IBOutlet weak var monthlyTitle: UILabel!
    @IBOutlet weak var monthlyPrice: UILabel!
    @IBOutlet weak var monthlyPeriod: UILabel!
    @IBOutlet weak var monthlyDescription: UILabel!
    @IBOutlet weak var monthlyArea: UIView!
    @IBOutlet weak var yearlyTitle: UILabel!
    @IBOutlet weak var yearlyPrice: UILabel!
    @IBOutlet weak var yearlyPeriod: UILabel!
    @IBOutlet weak var yearlyDescription: UILabel!
    @IBOutlet weak var yearlyArea: UIView!
    @IBOutlet var promoDescriptions: [UILabel]!
    @IBOutlet weak var backSpinnerView : UIView!
    @IBOutlet weak var shadowSpinnerView : UIView!
    @IBOutlet weak var spinnerView : JTMaterialSpinner!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
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
        crownImageView.image = UIImage(named: "crown")
    }
    
    private func configureLabels() {
        titleLabel.text = "Go Premium!"
        titleLabel.textColor = WARM_GREY
        titleLabel.font = FontSheet.FontBoldWith(size: MEGA_FONT_SIZE + 10)
        
        subtitleLabel.text = "And enjoy all the content"
        subtitleLabel.textColor = WARM_GREY
        subtitleLabel.font = FontSheet.FontBoldWith(size: MEGA_FONT_SIZE)
        
        setDescriptionText(priceWeek: "-", priceMonth: "-", priceYear: "-")
    }
    
    private func configureButtons() {
        
        weeklyTitle.text = "Weekly"
        weeklyTitle.font = FontSheet.FontRegularWith(size: BIG_FONT_SIZE)
        weeklyTitle.textColor = WHITE
        
        weeklyPrice.text = "-"
        weeklyPrice.font = FontSheet.FontRegularWith(size: BIG_FONT_SIZE)
        weeklyPrice.textColor = WHITE
        
        weeklyPeriod.text = "per week"
        weeklyPeriod.font = FontSheet.FontRegularWith(size: SMALLEST_FONT_SIZE - 2)
        weeklyPeriod.textColor = WHITE
        
        weeklyDescription.text = "billed weekly"
        weeklyDescription.font = FontSheet.FontLightWith(size: SMALL_FONT_SIZE)
        weeklyDescription.textColor = WHITE

        weeklyArea.layer.cornerRadius = 8.0
        weeklyArea.backgroundColor = DARK_SKY_BLUE
        weeklyArea.layer.borderWidth = 1.0
        weeklyArea.layer.borderColor = WHITE.withAlphaComponent(0.5).cgColor
        
        monthlyTitle.text = "Monthly"
        monthlyTitle.font = FontSheet.FontRegularWith(size: BIG_FONT_SIZE)
        monthlyTitle.textColor = WHITE
        
        monthlyPrice.text = "-"
        monthlyPrice.font = FontSheet.FontRegularWith(size: BIG_FONT_SIZE)
        monthlyPrice.textColor = WHITE
        
        monthlyPeriod.text = "per month"
        monthlyPeriod.font = FontSheet.FontRegularWith(size: SMALLEST_FONT_SIZE - 2)
        monthlyPeriod.textColor = WHITE
        
        monthlyDescription.text = "billed monthly"
        monthlyDescription.font = FontSheet.FontLightWith(size: SMALL_FONT_SIZE)
        monthlyDescription.textColor = WHITE
        
        monthlyArea.layer.cornerRadius = 8.0
        monthlyArea.backgroundColor = BORING_GREEN
        monthlyArea.layer.borderWidth = 1.0
        monthlyArea.layer.borderColor = WHITE.withAlphaComponent(0.5).cgColor
        
        yearlyTitle.text = "Yearly"
        yearlyTitle.font = FontSheet.FontRegularWith(size: BIG_FONT_SIZE)
        yearlyTitle.textColor = WHITE
        
        yearlyPrice.text = "-"
        yearlyPrice.font = FontSheet.FontRegularWith(size: BIG_FONT_SIZE)
        yearlyPrice.textColor = WHITE
        
        yearlyPeriod.text = "per year"
        yearlyPeriod.font = FontSheet.FontRegularWith(size: SMALLEST_FONT_SIZE - 2)
        yearlyPeriod.textColor = WHITE
        
        yearlyDescription.text = "billed yearly"
        yearlyDescription.font = FontSheet.FontLightWith(size: SMALL_FONT_SIZE)
        yearlyDescription.textColor = WHITE
        
        yearlyArea.layer.cornerRadius = 8.0
        yearlyArea.backgroundColor = YELLOW_COLOR
        yearlyArea.layer.borderWidth = 1.0
        yearlyArea.layer.borderColor = WHITE.withAlphaComponent(0.5).cgColor
    }
    
    private func configurePromoLabels() {
        let descriptions = ["Complete access to all content, relax and enjoy everything.",
                            "Remove ads.",
                            "Breathe without time limits and with background music."]
        promoDescriptions.enumerated().forEach {
            $1.text = descriptions[$0]
            $1.textColor = WARM_GREY
            $1.font = FontSheet.FontRegularWith(size: BIG_FONT_SIZE)
        }
    }
    
    private func setDescriptionText(priceWeek: String, priceMonth: String, priceYear: String) {
        
        let normalAttributes = [NSAttributedString.Key.font: FontSheet.FontRegularWith(size: SMALLEST_FONT_SIZE), NSAttributedString.Key.foregroundColor: WARM_GREY ]
        
        let description = NSMutableAttributedString(string: String(format: "Subscription for a period of (%@), (%@) or (%@).\nPayment will be charged to iTunes Account at confirmation of purchase.\nSubscription automatically renews unless auto-renew is turned off at least 24-hours before the end of the current period.\nAccount will be charged for renewal within 24-hours prior to the end of the current period with (%@), (%@) or (%@) .\nSubscriptions may be managed by the user and auto-renewal may be turned off by going to the user's Account Settings after purchase.", priceWeek, priceMonth, priceYear, priceWeek, priceMonth, priceYear), attributes: normalAttributes)
        let attributes = [NSAttributedString.Key.font: FontSheet.FontMediumWith(size: NORMAL_FONT_SIZE), NSAttributedString.Key.foregroundColor: BROWNISH_GREY ]
        
        let firstText = NSMutableAttributedString(string: "\n\n" + "Terms of use" + "\n", attributes: attributes)
        let firstLink = NSMutableAttributedString(string: "https://www.quiet.com/terms-of-use.html", attributes: normalAttributes)
        let secondText = NSMutableAttributedString(string: "\n\n" + "Privacy policy" + "\n", attributes: attributes)
        let secondLink = NSMutableAttributedString(string: "https://www.quiet.com/privacy-policy.html", attributes: normalAttributes)
        
        description.append(firstText)
        description.append(firstLink)
        description.append(secondText)
        description.append(secondLink)
        
        descriptionTextView.attributedText = description
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
    
    @objc func weekDidPressed() { presenter.weekDidPressed() }
    @objc func monthDidPressed() { presenter.monthDidPressed() }
    @objc func yearDidPressed() { presenter.yearDidPressed() }
    
    //MARK:-
    
    func setWeeklySubscriptionPrice(_ price: String) { weeklyPrice.text = price }
    func setMonthlySubscriptionPrice(_ price: String) { monthlyPrice.text = price }
    func setYearlySubscriptionPrice(_ price: String) { yearlyPrice.text = price }
    
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
}
