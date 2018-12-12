//
//  ALMainCollectionViewCell.swift
//  Quiet
//
//  Created by Alvaro on 23/11/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit

class ALMainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var title: ALLabel!
    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        commonInit()
    }

    
    //MARK:- private methods
    
    private func commonInit() {
        layer.cornerRadius = 6.0
        title.text = "Start"
        title.textColor = WHITE.withAlphaComponent(0.7)
        title.font = FontSheet.FontRegularWith(size: SMALL_FONT_SIZE)
        
        iconView.backgroundColor = WHITE.withAlphaComponent(0.7)
        iconView.layer.cornerRadius = iconView.bounds.height / 2.0
        iconView.layer.borderColor = WARM_GREY.cgColor
        iconView.layer.borderWidth = 2.0
        
        self.icon.contentMode = .scaleAspectFill
        self.icon.tintColor = BROWNISH_GREY
    }
    
    //MARK:- public methods
    
    func setCellTitle(_ title: String? = nil, background: UIImage? = nil, icon: UIImage? = nil) {
        self.title.text = title?.replacingOccurrences(of: " ", with: "\n")
        
        self.icon.image = icon?.withRenderingMode(.alwaysTemplate)
    }
}

class ALLabel: UILabel {
    override func drawText(in rect: CGRect) {
        
        
        super.drawText(in: rect)
    }
}
