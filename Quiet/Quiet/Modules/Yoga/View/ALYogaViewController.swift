//
//  ALYogaViewController.swift
//  Quiet
//
//  Created by Alvaro on 20/12/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import AVKit

class ALYogaViewController: AVPlayerViewController, ALYogaViewProtocol {
    var presenter: ALYogaPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
    
    func setVideo(_ videoURL: URL) { player = AVPlayer(url: videoURL) }
}
