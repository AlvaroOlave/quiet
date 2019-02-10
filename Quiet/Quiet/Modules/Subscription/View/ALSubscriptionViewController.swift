//
//  ALSubscriptionViewController.swift
//  Quiet
//
//  Created by Alvaro on 28/12/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit

class ALSubscriptionViewController: ALBaseViewController, ALSubscriptionViewProtocol {
    var presenter: ALSubscriptionPresenterProtocol!

    @IBOutlet weak var frameView: UIView!
    @IBOutlet weak var crownImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var weeklyButton: UIButton!
    @IBOutlet weak var monthlyButton: UIButton!
    @IBOutlet weak var yearlyButton: UIButton!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
        commonInit()
    }
    
    override func backButtonPressed() { presenter.backButtonPressed() }
    
    //MARK:- viewConfiguration
    
    private func commonInit() {
        configureView()
        configureButtons()
        configureLabels()
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
        
        subtitleLabel.text = "And enjoy all the content!"
        subtitleLabel.textColor = WARM_GREY
        subtitleLabel.font = FontSheet.FontBoldWith(size: MEGA_FONT_SIZE)
        
        setDescriptionText(priceWeek: "-", priceMonth: "-", priceYear: "-")
    }
    
    private func configureButtons() {
        weeklyButton.setTitle("-", for: .normal)
        weeklyButton.setTitleColor(WHITE, for: .normal)
        weeklyButton.layer.cornerRadius = 8.0
        weeklyButton.layer.borderWidth = 1.0
        weeklyButton.layer.borderColor = DARK_SKY_BLUE.withAlphaComponent(0.5).cgColor
        weeklyButton.backgroundColor = DARK_SKY_BLUE
        weeklyButton.titleLabel?.font = FontSheet.FontBoldWith(size: NORMAL_FONT_SIZE)
        
        monthlyButton.setTitle("-", for: .normal)
        monthlyButton.setTitleColor(WHITE, for: .normal)
        monthlyButton.layer.cornerRadius = 8.0
        monthlyButton.layer.borderWidth = 1.0
        monthlyButton.layer.borderColor = DARK_SKY_BLUE.withAlphaComponent(0.5).cgColor
        monthlyButton.backgroundColor = DARK_SKY_BLUE
        monthlyButton.titleLabel?.font = FontSheet.FontBoldWith(size: NORMAL_FONT_SIZE)
        
        yearlyButton.setTitle("-", for: .normal)
        yearlyButton.setTitleColor(WHITE, for: .normal)
        yearlyButton.layer.cornerRadius = 8.0
        yearlyButton.layer.borderWidth = 1.0
        yearlyButton.layer.borderColor = DARK_SKY_BLUE.withAlphaComponent(0.5).cgColor
        yearlyButton.backgroundColor = DARK_SKY_BLUE
        yearlyButton.titleLabel?.font = FontSheet.FontBoldWith(size: NORMAL_FONT_SIZE)
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
    
    //MARK:-
    
    func setWeeklySubscriptionPrice(_ price: String) { weeklyButton.setTitle(price, for: .normal) }
    func setMonthlySubscriptionPrice(_ price: String) { monthlyButton.setTitle(price, for: .normal) }
    func setYearlySubscriptionPrice(_ price: String) { yearlyButton.setTitle(price, for: .normal) }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
}
