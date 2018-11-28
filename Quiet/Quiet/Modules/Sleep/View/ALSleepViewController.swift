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
    @IBOutlet weak var separationView1: UIView!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var separationView2: UIView!
    @IBOutlet weak var playView: UIView!
    @IBOutlet weak var playIcon: UIImageView!
    
    @IBOutlet weak var keyboardConstraint: NSLayoutConstraint!
    
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
    
    //MARK:- viewConfiguration
    
    private func commonInit() {
        configurePlayButton()
        configureResourceInfo()
        configureTimeView()
    }
    
    private func configurePlayButton() {
        playIcon.image = UIImage(named: "icPlay")?.withRenderingMode(.alwaysTemplate)
        playIcon.tintColor = WHITE.withAlphaComponent(0.7)
        
        playView.layer.cornerRadius = playView.bounds.height / 2.0
        playView.layer.borderWidth = 2.0
        playView.layer.borderColor = LIGHT_GREY_BLUE.cgColor
        playView.backgroundColor = DARK_SKY_BLUE.withAlphaComponent(0.9)
    }
    
    private func configureResourceInfo() {
        resourceImage.contentMode = .scaleAspectFit
        resourceImage.layer.borderColor = WARM_GREY.cgColor
        resourceImage.layer.borderWidth = 2.0
        resourceImage.layer.cornerRadius = 4.0
        
        resourceTitle.text = "ResourceTitleAux "
        resourceTitle.textColor = BROWNISH_GREY
        resourceTitle.font = FontSheet.FontRegularWith(size: MEGA_FONT_SIZE)
    }
    
    private func configureTimeView() {
        separationView1.backgroundColor = MERCURY_GREY
        separationView2.backgroundColor = MERCURY_GREY
        
        dateTextField.font = FontSheet.FontRegularWith(size: BIG_FONT_SIZE)
        dateTextField.textColor = BROWNISH_GREY
        dateTextField.inputAccessoryView = configureDatePicker()
    }
    
    private func configureDatePicker() -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.backgroundColor = WHITE
        datePicker.datePickerMode = .countDownTimer
        datePicker.minuteInterval = 15
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: UIControl.Event.valueChanged)
        
        return datePicker
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        dateTextField.text = dateFormatter.string(from: sender.date)
        dateTextField.endEditing(true)
    }
    
    //MARK: - Notification methods
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let info = notification.userInfo else { return }
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        self.keyboardConstraint.constant = keyboardFrame.height + 10
        UIView.animate(withDuration: (notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double)) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.keyboardConstraint.constant = 112
        UIView.animate(withDuration: (notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double)) {
            self.view.layoutIfNeeded()
        }
    }
}
