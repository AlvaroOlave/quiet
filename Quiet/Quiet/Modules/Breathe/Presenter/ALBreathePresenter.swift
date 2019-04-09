//
//  ALBreathePresenter.swift
//  Quiet
//
//  Created by Alvaro on 20/11/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//
import UIKit
import AVFoundation

class ALBreathePresenter: NSObject, ALBreathePresenterProtocol, UIPickerViewDataSource, UIPickerViewDelegate {
    var view: ALBreatheViewProtocol!
    var dataManager: ALBreatheDataManagerProtocol!
    var wireframe: ALBreatheViewWireframeProtocol!
    
    var musicPlayer: AVAudioPlayer?
    
    var soundsList = [String]()
    
    func viewDidLoad() {
        dataManager.getResourcesList {
            if let list = $0 as? [String] {
                self.soundsList = list + ["without sound"]
                self.view.setSoundList()
                if self.soundsList.count > 0 {
                    self.view.selectElem((self.soundsList[0] as NSString).deletingPathExtension)
                    self.getSound(self.soundsList[0])
                }
            }
        }
    }
    
    func presentSubscriptionInterface() { wireframe.presentSubscriptionInterface() }
    
    func getLastBreatheTime() -> Double {
        let lastTime = UserDefaults.standard.double(forKey: "al_last_breathe_time")
        return lastTime == 0 ? 30.0 : lastTime
    }
    
    func setLastBreatheTime(_ time: Double) { UserDefaults.standard.set(time, forKey: "al_last_breathe_time") }
    func playAudio() { musicPlayer?.play() }
    func stopAudio() { musicPlayer?.stop(); musicPlayer?.currentTime = 0.0 }
    func backButtonPressed() { stopAudio(); wireframe.dismiss() }
    
    //MARK:- private methods
    
    private func initPlayer(_ data: Data) {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers])
            try AVAudioSession.sharedInstance().setActive(true)
            musicPlayer = try AVAudioPlayer(data: data)
            musicPlayer?.prepareToPlay()
            musicPlayer?.numberOfLoops = -1
            musicPlayer?.volume = 0.5
        } catch {
            //showError
        }
    }
    
    private func getSound(_ named: String) {
        dataManager.getResource(named) { [weak self] (sound) in
            if let data = sound { self?.initPlayer(data) }
        }
    }
    
    //MARK:- UIPickerViewDataSource methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return soundsList.count
    }
    
    //list.map({ return (($0 as NSString).deletingPathExtension) })
    
    //MARK:- UIPickerViewDelegate methods
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard row < soundsList.count else { return "" }
        return (soundsList[row] as NSString).deletingPathExtension
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard row < soundsList.count else { return }
        view.selectElem((soundsList[row] as NSString).deletingPathExtension)
        if row == soundsList.count - 1 {
            musicPlayer = nil
        } else {
            getSound(soundsList[row])
        }
    }
}
