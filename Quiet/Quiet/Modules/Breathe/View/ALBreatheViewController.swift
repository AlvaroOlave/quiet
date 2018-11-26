//
//  ALBreatheViewController.swift
//  Tests
//
//  Created by Alvaro on 17/11/2018.
//  Copyright © 2018 Alvaro. All rights reserved.
//

import UIKit

class ALBreatheViewController: UIViewController, ALBreatheViewProtocol {
    
    var presenter: ALBreathePresenterProtocol!

    @IBOutlet weak var breathView: ALBreathView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var backIcon: UIImageView!
    @IBOutlet weak var breathLabel: UILabel!
    @IBOutlet weak var subtButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var inspExpAreaView: UIView!
    @IBOutlet weak var inspireTimeLabel: UILabel!
    @IBOutlet weak var inspireLabel: UILabel!
    @IBOutlet weak var expireTimeLabel: UILabel!
    @IBOutlet weak var expireLabel: UILabel!
    @IBOutlet weak var separationView: UIView!
    
    var currentTimeSecs: Double {
        get {
            return presenter.getLastBreatheTime()
        }
        set {
            presenter.setLastBreatheTime(newValue)
        }
    }
    var breathTime = 5.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commonInit()
    }
    
    //MARK:- viewConfiguration
    
    private func commonInit() {
        configureGestures()
        configureLabels()
        configureButtons()
    }
    
    private func configureGestures() {
        breathView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(countdown)))
        breathView.isUserInteractionEnabled = true
    }
    
    private func configureLabels() {
        inspireTimeLabel.attributedText = attributtedLabel()
        
        inspireLabel.text = "inspire"
        inspireLabel.textColor = WARM_GREY
        inspireLabel.font = FontSheet.FontRegularWith(size: NORMAL_FONT_SIZE)
        
        expireTimeLabel.attributedText = attributtedLabel()
        
        expireLabel.text = "expire"
        expireLabel.textColor = WARM_GREY
        expireLabel.font = FontSheet.FontRegularWith(size: NORMAL_FONT_SIZE)
        
        breathLabel.text = "Start"
        breathLabel.textColor = BROWNISH_GREY
        breathLabel.font = FontSheet.FontRegularWith(size: MEGA_FONT_SIZE)
        
        setTimeLabel()
    }
    
    private func configureButtons() {
        subtButton.setTitleColor(DARK_SKY_BLUE, for: .normal)
        subtButton.titleLabel?.font = FontSheet.FontRegularWith(size: MEGA_FONT_SIZE * 2)
        subtButton.addTarget(self, action: #selector(subsSecs), for: .touchUpInside)
        
        addButton.setTitleColor(DARK_SKY_BLUE, for: .normal)
        addButton.titleLabel?.font = FontSheet.FontRegularWith(size: MEGA_FONT_SIZE * 2)
        addButton.addTarget(self, action: #selector(addSecs), for: .touchUpInside)
        
        cancelButton.layer.cornerRadius = cancelButton.bounds.height / 2.0
        cancelButton.backgroundColor = DARK_SKY_BLUE
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(WHITE, for: .normal)
        cancelButton.titleLabel?.font = FontSheet.FontRegularWith(size: NORMAL_FONT_SIZE)
        cancelButton.addTarget(self, action: #selector(cancelBreath), for: .touchUpInside)
        cancelButton.isHidden = true
        
        configureBackButton()
    }
    
    private func configureBackButton() {
        backView.backgroundColor = MERCURY_GREY
        backView.layer.cornerRadius = backView.bounds.height / 2.0
        backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backButtonPressed)))
        backView.isUserInteractionEnabled = true
        
        backIcon.image = UIImage(named: "icBackArrow")
    }
    
    @objc func backButtonPressed() { presenter.backButtonPressed() }
    
    @objc func addSecs() {
        currentTimeSecs += 2 * breathTime
        setTimeLabel()
    }
    
    @objc func subsSecs() {
        currentTimeSecs = max(currentTimeSecs - (2 * breathTime), 60.0)
        setTimeLabel()
    }
    
    private func setTimeLabel() { setTimeValue(currentTimeSecs) }
    
    private func setTimeValue(_ value: Double) {
        let desc = NSMutableAttributedString(string: "")
        
        let mins = Int(value / 60.0)
        if mins >= 1 {
            desc.append(NSMutableAttributedString(attributedString: NSMutableAttributedString(string: String(format: "%i", mins),
                                                                                             attributes: [NSAttributedString.Key.foregroundColor:BROWNISH_GREY,
                                                                                                          NSAttributedString.Key.font: FontSheet.FontRegularWith(size: BIG_FONT_SIZE)])))
            desc.append(NSMutableAttributedString(string: mins == 1 ? " min" : " mins",
                                                  attributes: [NSAttributedString.Key.foregroundColor:BROWNISH_GREY,
                                                               NSAttributedString.Key.font: FontSheet.FontRegularWith(size: NORMAL_FONT_SIZE) ]))
        }
        
        let secs = Int(value.truncatingRemainder(dividingBy: 60.0))
        if secs > 0 {
            desc.append(NSMutableAttributedString(attributedString: NSMutableAttributedString(string: String(format: " %i", secs),
                                                                                              attributes: [NSAttributedString.Key.foregroundColor:BROWNISH_GREY,
                                                                                                           NSAttributedString.Key.font: FontSheet.FontRegularWith(size: BIG_FONT_SIZE)])))
            desc.append(NSMutableAttributedString(string: " secs",
                                                  attributes: [NSAttributedString.Key.foregroundColor:BROWNISH_GREY,
                                                               NSAttributedString.Key.font: FontSheet.FontRegularWith(size: NORMAL_FONT_SIZE) ]))
        }
        
        timeLabel.attributedText = desc
    }
    
    private func attributtedLabel() -> NSAttributedString {
        
        let desc = NSMutableAttributedString(attributedString: NSMutableAttributedString(string: String(Int(breathTime)),
                                                                                         attributes: [NSAttributedString.Key.foregroundColor:DARK_SKY_BLUE,
                                                                                                      NSAttributedString.Key.font: FontSheet.FontBoldWith(size: BIG_FONT_SIZE)]))
        desc.append(NSMutableAttributedString(string: "secs",
                                              attributes: [NSAttributedString.Key.foregroundColor:DARK_SKY_BLUE,
                                                           NSAttributedString.Key.font: FontSheet.FontRegularWith(size: NORMAL_FONT_SIZE) ]))
        
        return desc
    }
    
    //MARK:- Animation methods
    
    @objc private func countdown() {
        breathView.gestureRecognizers?.forEach({ breathView.removeGestureRecognizer($0) })
        countodownTo(3)
    }
    
    private func countodownTo(_ count: Int) {
        breathLabel.alpha = 1.0
        guard count > 0 else { startBreathing(); return }
        breathLabel.text = String(count)
        breathLabel.font = FontSheet.FontRegularWith(size: MEGA_FONT_SIZE * 2)
        
        UIView.animate(withDuration: 1.0, animations: {
            self.breathLabel.alpha = 0.0
        }) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(250) ) { self.countodownTo(count - 1) }
        }
    }
    
    private func startBreathing() {
        breathLabel.font = FontSheet.FontRegularWith(size: MEGA_FONT_SIZE)
        startBreathing(Int(currentTimeSecs / (2 * breathTime)))
        hideInnecesaryElemsAnimated(true)
    }
    
    private func startBreathing(_ count: Int) {
        setTimeValue((2.0 * breathTime) * Double(count))
        guard count > 0 else { endBreathing() ; return }
        breathLabel.text = "Inspire"
        UIView.animate(withDuration: self.breathTime, animations: {
            self.breathView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { _ in
            UIView.animate(withDuration: self.breathTime, animations: {
                self.breathLabel.text = "Expire"
                self.breathView.transform = CGAffineTransform.identity
            }, completion: { _ in
                self.startBreathing(count - 1)
            })
        }
    }
    
    private func hideInnecesaryElemsAnimated(_ hide: Bool) {
        UIView.animate(withDuration: 0.25, animations: {
            self.setAlphaTo(0.0)
        }) { _ in
            self.hideInnecesaryElems(hide)
            self.setAlphaTo(1.0)
        }
    }
    
    private func hideInnecesaryElems(_ hide: Bool) {
        subtButton.isHidden = hide
        addButton.isHidden = hide
//        timeLabel.isHidden = hide
        inspireTimeLabel.isHidden = hide
        inspireLabel.isHidden = hide
        expireTimeLabel.isHidden = hide
        expireLabel.isHidden = hide
        separationView.isHidden = hide
        cancelButton.isHidden = !hide
    }
    
    private func setAlphaTo(_ value: CGFloat) {
        subtButton.alpha = value
        addButton.alpha = value
//        timeLabel.alpha = value
        inspireTimeLabel.alpha = value
        inspireLabel.alpha = value
        expireTimeLabel.alpha = value
        expireLabel.alpha = value
        separationView.alpha = value
    }
    
    @objc private func cancelBreath() { presenter.backButtonPressed() }
    
    private func endBreathing() {
        currentTimeSecs = presenter.getLastBreatheTime()
        hideInnecesaryElems(false)
        breathLabel.text = "Start"
        configureGestures()
        setTimeLabel()
    }
}

class ALBreathView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isOpaque = false
    }
    
    override func draw(_ rect: CGRect) {
        
        let ctx = UIGraphicsGetCurrentContext()
        
        let radius = min(frame.size.width, frame.size.height) * 0.5
        let viewCenter = CGPoint(x: bounds.size.width * 0.5, y: bounds.size.height * 0.5)
        
        let startAngle = -CGFloat.pi * 0.5
        let endAngle = startAngle + 2 * .pi * 50.0
        
        ctx?.setStrokeColor(DARK_SKY_BLUE.cgColor)
        ctx?.setLineWidth(12.0)
        
        ctx?.addArc(center: viewCenter, radius: radius - 6.0, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        ctx?.strokePath()
        
        ctx?.setStrokeColor(LIGHT_GREY_BLUE.withAlphaComponent(0.7).cgColor)
        ctx?.setLineWidth(12.0)

        ctx?.addArc(center: viewCenter, radius: radius - 16.0, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        ctx?.strokePath()
    }
}
