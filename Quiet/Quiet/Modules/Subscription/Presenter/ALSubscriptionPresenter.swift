//
//  ALSubscriptionPresenter.swift
//  Quiet
//
//  Created by Alvaro on 28/12/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit

enum SubscriptionMode: String {
    case Normal
    case Offer
}

class ALSubscriptionPresenter: ALSubscriptionPresenterProtocol, ALSubscriptionManagerDelegate {
    
    var view: ALSubscriptionViewProtocol!    
    var wireframe: ALSubscriptionWireframeProtocol!
    
    var mode: SubscriptionMode!
    
    func viewDidLoad() {
        ALPurchaseManager.shared.delegate = self
        mode == .Normal ? ALPurchaseManager.shared.loadSubscriptions() : ALPurchaseManager.shared.loadOfferedSubscriptions()
    }
    
    func backButtonPressed() { wireframe.dismiss() }
    
    func weekDidPressed() {
        _ = (mode == .Offer ? ALPurchaseManager.shared.purchaseOfferedWeeklySubscription() : ALPurchaseManager.shared.purchaseWeeklySubscription())
    }
    
    func monthDidPressed() {
        _ = (mode == .Offer ? ALPurchaseManager.shared.purchaseOfferedMonthlySubscription() : ALPurchaseManager.shared.purchaseMonthlySubscription())
    }
    
    func yearDidPressed() {
        _ = (mode == .Offer ? ALPurchaseManager.shared.purchaseOfferedYearlySubscription() : ALPurchaseManager.shared.purchaseYearlySubscription())
    }
    
    func restoreDidPressed() {
        ALPurchaseManager.shared.restorePurchases()
    }
    //MARK:- ALSubscriptionManagerDelegate methods
    
    func setWeeklySubscriptionPrice(_ price: NSDecimalNumber, units: String) {
        let weeklyPrice = createPriceAttributedString(with: price.doubleValue, units: units)
        view.setWeeklySubscriptionPrice(weeklyPrice)
    }
    func setMonthlySubscriptionPrice(_ price: NSDecimalNumber, units: String) {
        let monthlyPrice = createPriceAttributedString(with: price.doubleValue, units: units)
        view.setMonthlySubscriptionPrice(monthlyPrice)
    }
    func setYearlySubscriptionPrice(_ price: NSDecimalNumber, units: String) {
        let yearlyPrice = createPriceAttributedString(with: price.doubleValue, units: units)
        view.setYearlySubscriptionPrice(yearlyPrice)
    }
    
    func getAvailableProductsInProcess() { view.showLoading() }
    func getAvailableProductsCompleted() { view.hideLoading() }
    func getAvailableProductsFailed() { view.hideLoading() }
    func purchaising() { view.showLoading() }
    func endPurchase(_ purchased: Bool) { view.hideLoading(); if purchased { wireframe.dismiss(); wireframe.delegate?.subscribed() } }
    func showMessage(_ title: String, description: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        (view as? UIViewController)?.present(alert, animated: true)
    }
    
    //MARK:- private methods
    
    private func createPriceAttributedString(with price: Double, units: String) -> String {
        return String(format: "%.02f%@", price, units)
    }
    
    private func attributedText(_ text: String, color: UIColor, size: Float) -> NSAttributedString{
        
        let attrs : [NSAttributedString.Key : Any] = [ NSAttributedString.Key.font : FontSheet.FontRegularWith(size: size),
                                                       NSAttributedString.Key.foregroundColor : color ]
        
        return NSAttributedString(string: text, attributes: attrs)
    }
    
    private func defaultBackground() -> Data? {
        do {
            return try Data(contentsOf: Bundle.main.url(forResource: "woodHouse", withExtension: "gif")!)
        } catch  {
            return nil
        }
    }
}
