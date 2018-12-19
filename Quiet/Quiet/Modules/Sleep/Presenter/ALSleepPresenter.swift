//
//  ALSleepPresenter.swift
//  Quiet
//
//  Created by Alvaro on 27/11/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import AVFoundation

class ALSleepPresenter: ALSleepPresenterProtocol {
    var view: ALSleepViewProtocol!
    var wireframe: ALSleepViewWireframeProtocol!
    
    var elem: ALGeneralElem!
    
    var musicPlayer: AVAudioPlayer?
    
    func viewDidLoad() {
        view.setImage(elem.baseSection.imgURL,
                      title: elem.baseSection.title)
        
        initPlayers()
    }
    
    func initPlayers() {
        do {
            
            if let sec = elem.resource {
                musicPlayer = try AVAudioPlayer(data: sec)
                musicPlayer?.prepareToPlay()
                musicPlayer?.numberOfLoops = -1
            }
        } catch {
            //showError
        }
    }
    
    func backButtonPressed() { wireframe.dismiss() }
    
    func playButtonDidPressed() {}
    func pauseButtonDidPressed() {}
    func loopSeconds(_ secs: Double) {}
}
