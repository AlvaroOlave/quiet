//
//  ALSleepCastViewController.swift
//  Quiet
//
//  Created by Alvaro on 14/12/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit

class ALSleepCastViewController: ALBaseViewController, ALSleepCastViewProtocol {
    
    var presenter: ALSleepCastPresenterProtocol!
    
    @IBOutlet weak var frameView: UIView!
//    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var settingsView: UIView!
    @IBOutlet weak var settingsIcon: UIImageView!
    @IBOutlet weak var resourceImage: UIImageView!
    @IBOutlet weak var resourceTitle: UILabel!
    @IBOutlet weak var playView: UIView!
    @IBOutlet weak var playIcon: UIImageView!

    @IBOutlet weak var curtainView: UIView!
    @IBOutlet weak var curtainConstraint: NSLayoutConstraint!
    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var voiceImage: UIImageView!
    @IBOutlet weak var musicSlider: UISlider!
    @IBOutlet weak var voiceSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commonInit()
    }
    
    override func backButtonPressed() { presenter.backButtonPressed() }
    
    //MARK:- viewConfiguration
    
    private func commonInit() {
        configureFrameView()
        configurePlayButton()
        configureSettings()
        configureAudioCurtain()
    }
    
    private func configureFrameView() {
        frameView.layer.cornerRadius = 24
        backView?.backgroundColor = CLEAR_COLOR
        backIcon?.image = UIImage(named: "icCancel")?.withRenderingMode(.alwaysTemplate)
        backIcon?.tintColor = MERCURY_GREY
        view.backgroundColor = BROWNISH_GREY.withAlphaComponent(0.5)
    }
    
    private func configurePlayButton() {
        playIcon.image = UIImage(named: "icPlay")?.withRenderingMode(.alwaysTemplate)
        playIcon.tintColor = WHITE.withAlphaComponent(0.7)
        
        playView.layer.cornerRadius = playView.bounds.height / 2.0
        playView.layer.borderWidth = 2.5
        playView.layer.borderColor = MERCURY_GREY.withAlphaComponent(0.8).cgColor
        playView.backgroundColor = WARM_GREY.withAlphaComponent(0.9)
    }
    
    private func configureSettings() {
        settingsView.backgroundColor = CLEAR_COLOR
        settingsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(settingsButtonPressed)))
        settingsView.isUserInteractionEnabled = true
        
        settingsIcon.image = UIImage(named: "icSettings")?.withRenderingMode(.alwaysTemplate)
        settingsIcon.tintColor = MERCURY_GREY
    }
    
    @objc func settingsButtonPressed() {
        curtainConstraint.constant = curtainConstraint.constant == 0 ? 415 : 0
        UIView.animate(withDuration: 0.2) { self.view.layoutSubviews() }
    }
    
    private func configureAudioCurtain() {
        configureCurtainView()
        configureCurtainImages()
    }
    
    private func configureCurtainView() {
        curtainView.clipsToBounds = true
        let path = UIBezierPath(roundedRect:curtainView.bounds,
                                byRoundingCorners:[.bottomRight, .bottomLeft],
                                cornerRadii: CGSize(width: 20, height:  20))
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        curtainView.layer.mask = maskLayer
        curtainView.backgroundColor = BROWNISH_GREY.withAlphaComponent(0.98)
    }
    
    private func configureCurtainImages() {
        musicImage.image = UIImage(named: "icMusic")?.withRenderingMode(.alwaysTemplate)
        musicImage.tintColor = MERCURY_GREY.withAlphaComponent(0.8)
        voiceImage.image = UIImage(named: "icVoice")?.withRenderingMode(.alwaysTemplate)
        voiceImage.tintColor = MERCURY_GREY.withAlphaComponent(0.8)
    }
}
