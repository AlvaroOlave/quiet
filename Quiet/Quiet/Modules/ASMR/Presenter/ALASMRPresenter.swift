//
//  ALASMRPresenter.swift
//  Quiet
//
//  Created by Alvaro on 20/12/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import AVFoundation

class ALASMRPresenter: NSObject, ALASMRPresenterProtocol, AVAudioPlayerDelegate {
    var view: ALASMRViewProtocol!
    var wireframe: ALASMRWireframeProtocol!
    
    var elem: ALGeneralElem!
    
    var musicPlayer: AVAudioPlayer?
    
    func viewDidLoad() {
        view.setImage(elem.baseSection.imgURL)
        initPlayer()
    }
    
    func viewDidAppear() {
        playAudio()
    }
    
    func backButtonPressed() { stopAudio(); wireframe.dismiss() }
    
    private func initPlayer() {
        do {
            if let sound = elem.resource {
                musicPlayer = try AVAudioPlayer(data: sound)
                musicPlayer?.prepareToPlay()
                musicPlayer?.delegate = self
                musicPlayer?.volume = 0.0
            }
        } catch {
            //showError
        }
    }
    
    private func playAudio() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
            try AVAudioSession.sharedInstance().setActive(true)
            musicPlayer?.play()
            musicPlayer?.setVolume(0.7, fadeDuration: 2.5)
        } catch { }
    }
    
    private func stopAudio() { musicPlayer?.stop() }
    
    //MARK:- AVAudioPlayerDelegate methods
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) { stopAudio() }
}
