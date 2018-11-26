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

    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    func setTitle(_ title: String, backgroundImg: String, isPremium: Bool) {
        titleLabel.text = title
//        (backgroundView as? UIImageView)?.image =
        lockImage.isHidden = !isPremium
    }
    
    //MARK:- viewConfiguration
    
    private func commonInit() {
        
    }
}
