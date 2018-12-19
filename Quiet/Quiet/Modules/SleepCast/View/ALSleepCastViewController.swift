//
//  ALSleepCastViewController.swift
//  Quiet
//
//  Created by Alvaro on 14/12/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit
import SDWebImage

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
    
    var playGesture: UITapGestureRecognizer!
    var pauseGesture: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
        commonInit()
    }
    
    override func backButtonPressed() { presenter.backButtonPressed() }
    
    func setImage(_ img: String, title: String) {
        resourceImage.sd_setImage(with: URL(string: img), placeholderImage: nil)
        resourceTitle.text = title
    }
    
    func restorePlayButton() {
        playIcon.image = UIImage(named: "icPlay")?.withRenderingMode(.alwaysTemplate)
    }
    
    //MARK:- viewConfiguration
    
    private func commonInit() {
        configureFrameView()
        configurePlayButton()
        configureSettings()
        configureAudioCurtain()
        configureResourceView()
        configureSliders()
    }
    
    private func configureResourceView() {
        resourceImage.contentMode = .scaleAspectFill
        resourceImage.clipsToBounds = true
        resourceTitle.textColor = MERCURY_GREY
        resourceTitle.font = FontSheet.FontRegularWith(size: MEGA_FONT_SIZE)
    }
    
    private func configureFrameView() {
        frameView.layer.cornerRadius = 24
        backView?.backgroundColor = CLEAR_COLOR
        backIcon?.image = UIImage(named: "icCancel")?.withRenderingMode(.alwaysTemplate)
        backIcon?.tintColor = MERCURY_GREY
        view.backgroundColor = BROWNISH_GREY.withAlphaComponent(0.5)
        view.clipsToBounds = true
    }
    
    private func configurePlayButton() {
        playIcon.image = UIImage(named: "icPlay")?.withRenderingMode(.alwaysTemplate)
        playIcon.tintColor = WHITE.withAlphaComponent(0.7)
        playIcon.isUserInteractionEnabled = false
        
        playView.layer.cornerRadius = playView.bounds.height / 2.0
        playView.layer.borderWidth = 2.5
        playView.layer.borderColor = MERCURY_GREY.withAlphaComponent(0.8).cgColor
        playView.backgroundColor = WARM_GREY.withAlphaComponent(0.9)
        
        playGesture = UITapGestureRecognizer(target: self, action: #selector(playButtonPressed))
        
        playView.addGestureRecognizer(playGesture)
        playView.isUserInteractionEnabled = true
    }
    
    private func configureSettings() {
        settingsView.backgroundColor = CLEAR_COLOR
        settingsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(settingsButtonPressed)))
        settingsView.isUserInteractionEnabled = true
        
        settingsIcon.image = UIImage(named: "icSettings")?.withRenderingMode(.alwaysTemplate)
        settingsIcon.tintColor = MERCURY_GREY
    }
    
    private func configureSliders() {
        voiceSlider.addTarget(self, action: #selector (sliderValueDidChange), for: .valueChanged)
        voiceSlider.tintColor = MERCURY_GREY
        voiceSlider.maximumTrackTintColor = MERCURY_GREY
        voiceSlider.minimumValue = 0.0
        voiceSlider.maximumValue = 1.0
        voiceSlider.addTarget(self, action: #selector (sliderValueDidChange), for: .valueChanged)
        voiceSlider.value = 0.7
        
        musicSlider.addTarget(self, action: #selector (sliderValueDidChange), for: .valueChanged)
        musicSlider.tintColor = MERCURY_GREY
        musicSlider.maximumTrackTintColor = MERCURY_GREY
        musicSlider.minimumValue = 0.0
        musicSlider.maximumValue = 1.0
        musicSlider.addTarget(self, action: #selector (sliderValueDidChange), for: .valueChanged)
        musicSlider.value = 0.7
    }
    
    @objc func playButtonPressed() {
        presenter.playButtonDidPressed()
        if pauseGesture == nil { pauseGesture = UITapGestureRecognizer(target: self, action: #selector(pauseButtonPressed))}
        playView.removeGestureRecognizer(playGesture)
        playView.addGestureRecognizer(pauseGesture)
        playIcon.image = UIImage(named: "icPause")?.withRenderingMode(.alwaysTemplate)
    }
    
    @objc func pauseButtonPressed() {
        presenter.pauseButtonDidPressed()
        if playGesture == nil { playGesture = UITapGestureRecognizer(target: self, action: #selector(playButtonPressed))}
        playView.removeGestureRecognizer(pauseGesture)
        playView.addGestureRecognizer(playGesture)
        playIcon.image = UIImage(named: "icPlay")?.withRenderingMode(.alwaysTemplate)
    }
    
    @objc func settingsButtonPressed() {
        curtainConstraint.constant = curtainConstraint.constant == 0 ? 205 : 0
        UIView.animate(withDuration: 0.2) { self.view.layoutIfNeeded() }
    }
    
    @objc func sliderValueDidChange(sender: UISlider!) {
        if sender == musicSlider { presenter.musicVolume(sender.value) }
        else if sender == voiceSlider { presenter.voiceVolume(sender.value) }
    }
    
    private func configureAudioCurtain() {
        configureCurtainView()
        configureCurtainImages()
    }
    
    private func configureCurtainView() {
        curtainView.clipsToBounds = true
        curtainConstraint.constant = 0
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
