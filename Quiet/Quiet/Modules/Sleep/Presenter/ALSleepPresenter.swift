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
    
    func backButtonPressed() { stopAudio(); wireframe.dismiss() }
    
    func playButtonDidPressed() { playAudio() }
    func pauseButtonDidPressed() { musicPlayer?.pause() }
    func loopSeconds(_ secs: Double) {
        
    }
    
    private func playAudio() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
            try AVAudioSession.sharedInstance().setActive(true)
            musicPlayer?.play()
        } catch {
            
        }
    }
    
    private func stopAudio() { musicPlayer?.stop() }
}
