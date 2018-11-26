//
//  ALMainCollectionViewCell.swift
//  Quiet
//
//  Created by Alvaro on 23/11/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit

class ALMainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        commonInit()
    }

    
    //MARK:- private methods
    
    private func commonInit() {
        layer.cornerRadius = 6.0
        title.text = "Start"
        title.textColor = WARM_GREY
        title.font = FontSheet.FontRegularWith(size: SMALL_FONT_SIZE)
        
        icon.layer.cornerRadius = icon.bounds.height / 2.0
        icon.layer.borderColor = WARM_GREY.cgColor
        icon.layer.borderWidth = 2.0
    }
    
    //MARK:- public methods
    
    func setCellTitle(_ title: String? = nil, background: UIImage? = nil, icon: UIImage? = nil) {
        self.title.text = title?.replacingOccurrences(of: " ", with: "\n")
        
        self.icon.image = icon
    }
}
