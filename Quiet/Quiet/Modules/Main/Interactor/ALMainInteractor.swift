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
