//
//  ALBaseViewController.swift
//  Quiet
//
//  Created by Alvaro on 27/11/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit

class ALBaseViewController: UIViewController {
    
    @IBOutlet weak var backView: UIView?
    @IBOutlet weak var backIcon: UIImageView?
    
    override var shouldAutorotate: Bool { return false }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { return .portrait }

    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    private func commonInit() {
        configureBackButton()
    }
    
    private func configureBackButton() {
        backView?.backgroundColor = MERCURY_GREY
        backView?.layer.cornerRadius = (backView?.bounds.height ?? 0.0) / 2.0
        backView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backButtonPressed)))
        backView?.isUserInteractionEnabled = true
        
        backIcon?.image = UIImage(named: "icBack")
    }
    
    @objc func backButtonPressed() { }
}
