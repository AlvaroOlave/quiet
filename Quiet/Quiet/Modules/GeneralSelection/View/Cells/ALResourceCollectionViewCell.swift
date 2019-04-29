//
//  ALResourceCollectionViewCell.swift
//  Quiet
//
//  Created by Alvaro on 26/11/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit
import SDWebImage

class ALResourceCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lockImage: UIImageView!
    @IBOutlet weak var backgroungImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    func setTitle(_ title: String, backgroundImg: String, isPremium: Bool) {
        titleLabel.text = title
        
        var urlStr = backgroundImg
        if backgroundImg.contains(".jpg") {
            let comps = backgroundImg.components(separatedBy: ".jpg")
            var comps2 = comps[0].components(separatedBy: "/")
            let last = comps2.removeLast()
            comps2.append("thumbnail_" + last)
            let first = comps2.removeFirst()
            let retComps2 = comps2.reduce(first, { return $0 + "/" + $1 })
            urlStr = retComps2 + ".jpg" + comps[1]
        }
        
        backgroungImage.sd_setImage(with: URL(string: urlStr)) { [weak self] (img, error, origin, url) in
            if img == nil {
                self?.backgroungImage.sd_setImage(with: URL(string: backgroundImg)) { [weak self] (img, error, origin, url) in
                    self?.backgroungImage.image = img
                    if error == nil { self?.layer.borderColor = CLEAR_COLOR.cgColor }
                }
            } else {
                self?.backgroungImage.image = img
                if error == nil { self?.layer.borderColor = CLEAR_COLOR.cgColor }
            }
        }        
        lockImage.isHidden = !isPremium
    }
    
    //MARK:- viewConfiguration
    
    private func commonInit() {
        lockImage.image = UIImage(named: "icLock")?.withRenderingMode(.alwaysTemplate)
        lockImage.tintColor = WARM_GREY
        
        backgroungImage.contentMode = .scaleAspectFill
        
        titleLabel.textColor = WHITE_TWO
        titleLabel.font = FontSheet.FontRegularWith(size: NORMAL_FONT_SIZE)
        
        layer.cornerRadius = 6.0
        layer.borderColor = WARM_GREY.cgColor
        layer.borderWidth = 2.0
    }
}
