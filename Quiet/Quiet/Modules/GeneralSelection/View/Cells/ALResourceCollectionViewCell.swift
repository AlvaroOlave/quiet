//
//  ALResourceCollectionViewCell.swift
//  Quiet
//
//  Created by Alvaro on 26/11/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit

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

        lockImage.isHidden = !isPremium
    }
    
    //MARK:- viewConfiguration
    
    private func commonInit() {
        lockImage.image = UIImage(named: "icLock")?.withRenderingMode(.alwaysTemplate)
        lockImage.tintColor = WARM_GREY
        
        titleLabel.textColor = WARM_GREY
        titleLabel.font = FontSheet.FontRegularWith(size: NORMAL_FONT_SIZE)
        
        layer.cornerRadius = 6.0
        layer.borderColor = WARM_GREY.cgColor
        layer.borderWidth = 2.0
    }
}
