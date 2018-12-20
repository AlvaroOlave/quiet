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
    
    var sleepTimer: TimeInterval? = 3600.0
    
    var workItem: DispatchWorkItem!
    
    func viewDidLoad() {
        view.setImage(elem.baseSection.imgURL,
                      title: elem.baseSection.title)
        
        initPlayer()
        initWorkItem()
    }
    
    private func initPlayer() {
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
    
    private func initWorkItem() { workItem = DispatchWorkItem { [weak self] in self?.stop() } }
    
    func backButtonPressed() { cancelTimer(); wireframe.dismiss() }
    
    func playButtonDidPressed() { playAudio(); startTimer() }
    func pauseButtonDidPressed() { cancelTimer() }
    func loopSeconds(_ secs: Double) { sleepTimer = secs }
    
    private func playAudio() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
            try AVAudioSession.sharedInstance().setActive(true)
            musicPlayer?.play()
        } catch {
            
        }
    }
    private func stop() {
        self.stopAudio()
        DispatchQueue.main.async { self.view.restorePlayButton() }
    }
    private func stopAudio() { musicPlayer?.stop(); musicPlayer?.currentTime = 0.0 }
    
    private func startTimer() {
        if workItem.isCancelled { initWorkItem() }
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + (sleepTimer ?? 0.0), execute: workItem)
    }
    
    private func cancelTimer() { workItem.cancel(); stop() }
}
