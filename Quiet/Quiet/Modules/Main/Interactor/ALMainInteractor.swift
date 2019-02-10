//
//  ALMainInteractor.swift
//  Quiet
//
//  Created by Alvaro on 19/01/2019.
//  Copyright © 2019 surflabapps. All rights reserved.
//

import Foundation

let LAST_ADVICE_INDEX = "LAST_ADVICE_INDEX"
let LAST_ADVICE_DATE = "LAST_ADVICE_DATE"
let NEXT_BACKGROUND_NAME = "NEXT_BACKGROUND_NAME"
let NEXT_BACKGROUND_SOUND = "NEXT_BACKGROUND_SOUND"

class ALMainInteractor: ALMainInteractorProtocol {
    var dataManager: ALMainDataManagerProtocol!
    
    func getAllResourceLists() { dataManager.getAllResourceLists() }
    
    func getDailyAdvise(_ completion: @escaping (String?) -> Void) {
        dataManager.getAllDailyAdvices { (resp) in
            if let advices = resp {
                var idx = self.nextIndexUsed(withIncrease: !self.lastTimeInTheSameDay())
                if idx >= advices.count {
                    self.resetIndexUsed()
                    idx = 0
                }
                self.refreshLastDateReaded()
                completion(advices[idx])
            }
        }
    }
    
    func getNextBackground(_ completion: @escaping (Data?, Data?) -> Void) {
        if let nextName = UserDefaults.standard.object(forKey: NEXT_BACKGROUND_NAME) as? String,
            let nextSound = UserDefaults.standard.object(forKey: NEXT_BACKGROUND_SOUND) as? String {
            dataManager.getLocalFile(nextName) { [weak self] data in
                self?.dataManager.getLocalFile(nextSound, { (soundData) in
                    completion(data ?? self?.defaultBackground(), soundData)
                })
                
            }
        } else {
            completion(defaultBackground(), nil)
        }
        setNextBackground()
    }
    
    private func setNextBackground() {
        dataManager.getAllAvailableBackgrounds { [weak self] (elems) in
            let names = ALBackgroundElem.backgroundElemsFrom(dict: elems)
            if names.count > 0 {
                if let nextName = UserDefaults.standard.object(forKey: NEXT_BACKGROUND_NAME) as? String,
                    let idx = names.firstIndex(where: { return $0.gifURL == nextName }), idx % names.count < names.count {
                    self?.downloadBackgroundGIF(names[idx % names.count].gifURL)
                    self?.downloadBackgroundSound(names[idx % names.count].soundURL)
                } else {
                    self?.downloadBackgroundGIF(names.first?.gifURL)
                    self?.downloadBackgroundSound(names.first?.soundURL)
                }
            }
        }
    }
    
    private func downloadBackgroundGIF(_ named: String?) {
        guard let named = named else { return }
        dataManager.downloadbackground(named, { if $0 { UserDefaults.standard.set(named, forKey: NEXT_BACKGROUND_NAME) } })
    }
    
    private func downloadBackgroundSound(_ named: String?) {
        guard let named = named else { return }
        dataManager.downloadbackground(named, { if $0 { UserDefaults.standard.set(named, forKey: NEXT_BACKGROUND_SOUND) } })
    }
    
    private func defaultBackground() -> Data? {
        do {
            return try Data(contentsOf: Bundle.main.url(forResource: "waterfall", withExtension: "gif")!)
        } catch  {
            return nil
        }
    }

    private func nextIndexUsed(withIncrease: Bool) -> Int {
        let next = UserDefaults.standard.integer(forKey: LAST_ADVICE_INDEX)
        if withIncrease { UserDefaults.standard.set(next + 1, forKey: LAST_ADVICE_INDEX) }

        return next
    }
    
    private func resetIndexUsed() { UserDefaults.standard.set(0, forKey: LAST_ADVICE_INDEX) }
    private func refreshLastDateReaded() { UserDefaults.standard.set(Date(), forKey: LAST_ADVICE_DATE) }
    private func lastDateReaded() -> Date { return UserDefaults.standard.object(forKey: LAST_ADVICE_DATE) as? Date ?? Date() }
    private func lastTimeInTheSameDay() -> Bool { return Calendar.current.compare(lastDateReaded(), to: Date(), toGranularity: .day) == .orderedSame }
}
