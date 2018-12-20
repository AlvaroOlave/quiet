//
//  ALLandscapeViewController.swift
//  Quiet
//
//  Created by Alvaro on 20/12/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit

class ALLandscapeViewController: ALBaseViewController, ALLandscapeViewProtocol {
    
    @IBOutlet weak var backgroundImage: UIImageView?
    @IBOutlet weak var curtineView: UIView?
    
    var presenter: ALLandscapePresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        commonInit()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { return .landscape }
    override var shouldAutorotate: Bool { return true }
    
    override func backButtonPressed() { presenter.backButtonPressed() }
    
    func setImage(_ image: UIImage, animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseInOut, animations: {
                self.curtineView?.layer.backgroundColor = WHITE.cgColor
            }) { _ in
                self.backgroundImage?.image = image
                UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseInOut, animations: {
                    self.curtineView?.layer.backgroundColor = CLEAR_COLOR.cgColor
                }) { _ in
                    
                }
            }
        } else {
            backgroundImage?.image = image
        }
    }
    
    //MARK:- viewConfiguration
    
    private func commonInit() {
        backgroundImage?.contentMode = .scaleAspectFill
        
        curtineView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(curtinePressed)))
        curtineView?.isUserInteractionEnabled = true
    }
    
    @objc func curtinePressed() {
        UIView.animate(withDuration: 0.2) {
            self.backView?.alpha = self.backView?.alpha == 1.0 ? 0.0 : 1.0
        }
    }
}
