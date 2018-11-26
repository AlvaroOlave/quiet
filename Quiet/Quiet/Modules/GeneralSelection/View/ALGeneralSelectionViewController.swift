//
//  ALGeneralSelectionViewController.swift
//  Quiet
//
//  Created by Alvaro on 26/11/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit

class ALGeneralSelectionViewController: UIViewController, ALGeneralSelectionViewProtocol {
    var presenter: (ALGeneralSelectionPresenterProtocol & UICollectionViewDataSource & UICollectionViewDelegate)!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
