//
//  ALSubscriptionPresenter.swift
//  Quiet
//
//  Created by Alvaro on 28/12/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import Foundation

class ALSubscriptionPresenter: ALSubscriptionPresenterProtocol, ALSubscriptionManagerDelegate {
    
    var view: ALSubscriptionViewProtocol!    
    var wireframe: ALSubscriptionWireframeProtocol!
    
    func viewDidLoad() {
        
    }
    
    func backButtonPressed() { wireframe.dismiss() }
    
    //MARK:- ALSubscriptionManagerDelegate methods
    
    func setWeeklySubscriptionPrice(_ price: NSDecimalNumber, units: String) { }
    func setMonthlySubscriptionPrice(_ price: NSDecimalNumber, units: String) { }
    func setYearlySubscriptionPrice(_ price: NSDecimalNumber, units: String) { }
    
    func getAvailableProductsInProcess() { }
    
    func getAvailableProductsCompleted() { }
    
    func getAvailableProductsFailed() { }
    
    func purchaising() { }
    
    func endPurchase(_ purchased: Bool) { }
    
    func showMessage(_ title: String, description: String) { }
}
