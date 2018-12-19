//
//  ALSleepCastCastPresenter.swift
//  Quiet
//
//  Created by Alvaro on 14/12/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//
import AVFoundation

class ALSleepCastPresenter: NSObject, ALSleepCastPresenterProtocol, AVAudioPlayerDelegate {
    
    var view: ALSleepCastViewProtocol!
    var wireframe: ALSleepCastViewWireframeProtocol!
    
    var elem: ALSleepCastElem!
    
    var voicePlayer: AVAudioPlayer?
    var musicPlayer: AVAudioPlayer?
    
    func viewDidLoad() {
        view.setImage(elem.baseSection.imgURL,
                      title: elem.baseSection.title)
        initPlayers()
    }
    
    func initPlayers() {
        do {
            if let prim = elem.primarySound {
                voicePlayer = try AVAudioPlayer(data: prim)
                voicePlayer?.prepareToPlay()
                voicePlayer?.delegate = self
            }
            if let sec = elem.secondarySound {
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
    
    func pauseButtonDidPressed() { musicPlayer?.pause(); voicePlayer?.pause() }
    
    func musicVolume(_ volume: Float) { musicPlayer?.setVolume(volume, fadeDuration: 0.1) }
    
    func voiceVolume(_ volume: Float) { voicePlayer?.setVolume(volume, fadeDuration: 0.1) }
    
    private func playAudio() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
            try AVAudioSession.sharedInstance().setActive(true)
            musicPlayer?.play()
            voicePlayer?.play()
        } catch {
            
        }
    }
    
    private func stopAudio() { musicPlayer?.stop(); voicePlayer?.stop() }
    
    //MARK:- AVAudioPlayerDelegate methods
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) { musicPlayer?.stop(); view.restorePlayButton() }
}
