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
//    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        commonInit()
    }

//    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
//        
//        return CGSize(width: frame.width / 2.0, height: 150)
//    }
    
    //MARK:- private methods
    
    private func commonInit() {
        layer.cornerRadius = 6.0
        title.text = "Start"
        title.textColor = BROWNISH_GREY
        title.font = FontSheet.FontRegularWith(size: BIG_FONT_SIZE)
    }
    
    //MARK:- public methods
    
    func setCellTitle(_ title: String? = nil, background: UIImage? = nil, icon: UIImage? = nil) {
        self.title.text = title
        (backgroundView as? UIImageView)?.image = background
        backgroundColor = BORING_GREEN
        self.icon.image = icon
    }
}
