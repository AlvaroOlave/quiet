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

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
    
    override func backButtonPressed() { presenter.backButtonPressed() }
    
    //MARK:-
    
    func setWeeklySubscriptionPrice(_ price: String) {
        
    }
    
    func setMonthlySubscriptionPrice(_ price: String) {
        
    }
    
    func setYearlySubscriptionPrice(_ price: String) {
        
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
}
