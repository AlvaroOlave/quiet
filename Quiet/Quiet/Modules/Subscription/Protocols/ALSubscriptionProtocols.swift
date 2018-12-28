//
//  ALSubscriptionProtocols.swift
//  Quiet
//
//  Created by Alvaro on 28/12/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit

protocol ALSubscriptionViewProtocol {
    var presenter: ALSubscriptionPresenterProtocol! {get set}
    
    func setWeeklySubscriptionPrice(_ price: String)
    func setMonthlySubscriptionPrice(_ price: String)
    func setYearlySubscriptionPrice(_ price: String)
    func showLoading()
    func hideLoading()
}

protocol ALSubscriptionPresenterProtocol {
    var view: ALSubscriptionViewProtocol! {get set}
    var wireframe: ALSubscriptionWireframeProtocol! {get set}
    
    var mode: SubscriptionMode! {get set}
    
    func viewDidLoad()
    func backButtonPressed()
}

protocol ALSubscriptionWireframeProtocol {
    var view: (ALSubscriptionViewProtocol & UIViewController)! {get set}
    
    func presentSubscriptionViewIn(_ view: UIViewController)
    func dismiss()
}
