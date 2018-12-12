//
//  ALSubscriptionPopup.swift
//  Quiet
//
//  Created by Alvaro on 12/12/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit

class ALSubscriptionPopup: UIView, ALSubscriptionManagerDelegate {
    
    
    //MARK:- ALSubscriptionManagerDelegate methods
    
    func getAvailableProductsInProcess() { }
    
    func getAvailableProductsCompleted() { }
    
    func getAvailableProductsFailed() { }
    
    func purchaising() { }
    
    func endPurchase(_ purchased: Bool) { }
    
    func showMessage(_ title: String, description: String) { }
    
    func setYearlySubscriptionPrice(_ price: NSDecimalNumber, units: String) { }
    
    func setMonthlySubscriptionPrice(_ price: NSDecimalNumber, units: String) { }
    

}
