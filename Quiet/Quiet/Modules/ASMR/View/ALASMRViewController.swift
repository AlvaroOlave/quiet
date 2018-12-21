//
//  ALASMRViewController.swift
//  Quiet
//
//  Created by Alvaro on 20/12/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit
import SDWebImage

class ALASMRViewController: ALBaseViewController, ALASMRViewProtocol {
    var presenter: ALASMRPresenterProtocol!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
        presenter.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in self?.curtinePressed() }
    }
    
    override func backButtonPressed() { presenter.backButtonPressed() }
    
    func setImage(_ img: String) {
        backgroundImage.sd_setImage(with: URL(string: img), placeholderImage: nil)
    }
    
    //MARK:- viewConfiguration
    
    private func commonInit() {
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(curtinePressed)))
        backgroundImage.isUserInteractionEnabled = true
    }
    
    @objc func curtinePressed() {
        UIView.animate(withDuration: 0.2) {
            self.backView?.alpha = self.backView?.alpha == 1.0 ? 0.0 : 1.0
        }
    }
}
