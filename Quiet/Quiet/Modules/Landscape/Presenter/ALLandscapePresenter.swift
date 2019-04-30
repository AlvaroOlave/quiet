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
    
    var workItem: DispatchWorkItem!
    
    func viewDidLoad() {
        if let imgData = elem.images?.first {
            view.setImage(imgData, animated: false)
            currentIndex = 1 % (elem.images ?? []).count
        }
        initPlayer()
//        initWorkItem()
    }
    
    func viewWillAppear() {
//        initCarousel()
        playAudio()
    }
    
    func backButtonPressed() { stopAudio();  wireframe.dismiss() } // workItem.cancel();
    
    private func initCarousel() {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 15.0, execute: workItem)
    }
    
    private func initPlayer() {
        do {
            if let sound = elem.sound {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers])
                try AVAudioSession.sharedInstance().setActive(true)
                musicPlayer = try AVAudioPlayer(data: sound)
                musicPlayer?.prepareToPlay()
                musicPlayer?.numberOfLoops = -1
                musicPlayer?.volume = 0.0
            }
        } catch {
            //showError
        }
    }
    
    private func initWorkItem() {
        workItem = DispatchWorkItem {
            if let imgData = self.elem.images?[self.currentIndex] {
                DispatchQueue.main.async { self.view.setImage(imgData, animated: true) }
                self.currentIndex = (self.currentIndex + 1) % (self.elem.images ?? []).count
                self.initCarousel()
            }
        }
    }
    
    private func playAudio() {
        musicPlayer?.play()
        musicPlayer?.setVolume(0.7, fadeDuration: 2.5)
    }
    
    private func stopAudio() { musicPlayer?.stop() }
    
}
