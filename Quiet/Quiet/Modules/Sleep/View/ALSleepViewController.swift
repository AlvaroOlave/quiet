//
//  ALSleepViewController.swift
//  Quiet
//
//  Created by Alvaro on 27/11/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit

class ALSleepViewController: ALBaseViewController, ALSleepViewProtocol {
    
    @IBOutlet weak var resourceImage: UIImageView!
    @IBOutlet weak var resourceTitle: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var separationView1: UIView!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var playView: UIView!
    @IBOutlet weak var playIcon: UIImageView!
    
    @IBOutlet weak var keyboardConstraint: NSLayoutConstraint!
    
    var playGesture: UITapGestureRecognizer!
    var pauseGesture: UITapGestureRecognizer!
    
    let dateFormatter = DateFormatter()
    
    var presenter: ALSleepPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func backButtonPressed() { presenter.backButtonPressed() }
    
    func setImage(_ img: String, title: String) {
        resourceImage.sd_setImage(with: URL(string: img), placeholderImage: nil)
        resourceTitle.text = title
    }
    
    func restorePlayButton() {
        playIcon.image = UIImage(named: "icPlay")?.withRenderingMode(.alwaysTemplate)
        playView.addGestureRecognizer(playGesture)
        UIView.animate(withDuration: 0.2) {
            self.playView.alpha = 1.0
            self.descriptionLabel.alpha = 1.0
            self.separationView1.alpha = 1.0
            self.dateTextField.alpha = 1.0
        }
    }
    
    //MARK:- viewConfiguration
    
    private func commonInit() {
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        configurePlayButton()
        configureResourceInfo()
        configureTimeView()
        backView?.backgroundColor = WHITE.withAlphaComponent(0.7)
        view.backgroundColor = BLACK
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
    
    private func configureResourceInfo() {
        resourceImage.contentMode = .scaleAspectFit
        
        resourceTitle.text = "ResourceTitleAux "
        resourceTitle.textColor = WHITE_TWO
        resourceTitle.font = FontSheet.FontRegularWith(size: MEGA_FONT_SIZE)
    }
    
    private func configureTimeView() {
        separationView1.backgroundColor = WHITE.withAlphaComponent(0.8)
        
        descriptionLabel.font = FontSheet.FontRegularWith(size: SMALL_FONT_SIZE)
        descriptionLabel.textColor = WHITE.withAlphaComponent(0.8)
        
        dateTextField.font = FontSheet.FontRegularWith(size: BIG_FONT_SIZE)
        dateTextField.textColor = WHITE.withAlphaComponent(0.8)
        dateTextField.inputAccessoryView = getAccessoryView()
        dateTextField.inputView = configureDatePicker()
    }
    
    private func configureDatePicker() -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.backgroundColor = WHITE
        datePicker.datePickerMode = .countDownTimer
        datePicker.minuteInterval = 15
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: UIControl.Event.valueChanged)
        datePicker.timeZone = TimeZone(abbreviation: "UTC")
        datePicker.date = Date(timeIntervalSince1970: 3600)
        datePickerValueChanged(sender: datePicker)
        return datePicker
    }
    
    func getAccessoryView() -> UIToolbar {
        let toolBar = UIToolbar()
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector (doneKeyboardButtonPressed))
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.setItems([doneButton, space], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        return toolBar
    }
    
    @objc func doneKeyboardButtonPressed() { dateTextField.endEditing(true) }
    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        dateTextField.text = dateFormatter.string(from: sender.date)
        presenter.loopSeconds(sender.date.timeIntervalSince1970)
    }
    
    @objc func playButtonPressed() {
        presenter.playButtonDidPressed()
        UIView.animate(withDuration: 0.2) {
            self.playView.alpha = 0.0
            self.descriptionLabel.alpha = 0.0
            self.separationView1.alpha = 0.0
            self.dateTextField.alpha = 0.0
        }
//        if pauseGesture == nil { pauseGesture = UITapGestureRecognizer(target: self, action: #selector(pauseButtonPressed))}
//        playView.removeGestureRecognizer(playGesture)
//        playView.addGestureRecognizer(pauseGesture)
//        playIcon.image = UIImage(named: "icStop")?.withRenderingMode(.alwaysTemplate)
    }
    
    @objc func pauseButtonPressed() {
        presenter.pauseButtonDidPressed()
        if playGesture == nil { playGesture = UITapGestureRecognizer(target: self, action: #selector(playButtonPressed))}
        playView.removeGestureRecognizer(pauseGesture)
        playView.addGestureRecognizer(playGesture)
        playIcon.image = UIImage(named: "icPlay")?.withRenderingMode(.alwaysTemplate)
    }
    
    //MARK: - Notification methods
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let info = notification.userInfo else { return }
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        self.keyboardConstraint.constant = keyboardFrame.height - 54
        UIView.animate(withDuration: (notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double)) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.keyboardConstraint.constant = 8
        UIView.animate(withDuration: (notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double)) {
            self.view.layoutIfNeeded()
        }
    }
}
