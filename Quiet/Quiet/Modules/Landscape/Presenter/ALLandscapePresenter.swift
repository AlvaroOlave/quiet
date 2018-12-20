//
//  ALLandscapePresenter.swift
//  Quiet
//
//  Created by Alvaro on 20/12/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit
import AVFoundation

class ALLandscapePresenter: ALLandscapePresenterProtocol {
    var view: ALLandscapeViewProtocol!
    var wireframe: ALLandscapeWireframeProtocol!
    
    var elem: ALLandscapeElem!
    
    var musicPlayer: AVAudioPlayer?
    var currentIndex = 0
    
    func viewDidLoad() {
        if let imgData = elem.images?.first, let img = UIImage(data: imgData) {
            view.setImage(img, animated: false)
            currentIndex = 1 % (elem.images ?? []).count
        }
        initPlayer()
    }
    
    func viewWillAppear() {
        initCarousel()
        playAudio()
    }
    
    func backButtonPressed() { stopAudio(); wireframe.dismiss() }
    
    private func initCarousel() {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 5.0) {
            if let imgData = self.elem.images?[self.currentIndex], let img = UIImage(data: imgData) {
                DispatchQueue.main.async { self.view.setImage(img, animated: true) }
                self.currentIndex = (self.currentIndex + 1) % (self.elem.images ?? []).count
                self.initCarousel()
            }
        }
    }
    
    private func initPlayer() {
        do {
            if let sound = elem.sound {
                musicPlayer = try AVAudioPlayer(data: sound)
                musicPlayer?.prepareToPlay()
                musicPlayer?.numberOfLoops = -1
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
    
}
