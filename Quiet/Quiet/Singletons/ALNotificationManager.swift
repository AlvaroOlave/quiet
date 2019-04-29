//
//  ALNotificationManager.swift
//  Quiet
//
//  Created by Alvaro on 29/04/2019.
//  Copyright © 2019 surflabapps. All rights reserved.
//

import UIKit
import UserNotifications

struct Notification {
    var id:String
    var title:String
    var datetime:DateComponents
}


class ALNotificationManager {
    
    static let shared = ALNotificationManager()
    
    var notifications = [Notification]()
    
    func scheduledNotifications() {
        UNUserNotificationCenter.current().getPendingNotificationRequests {
            if $0.isEmpty {
                self.schedule()
            }
        }
    }
    
    private func schedule() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                self.requestAuthorization()
            case .authorized, .provisional:
                self.scheduleNotifications()
            default:
                break // Do nothing
            }
        }
    }
    
    private func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                DispatchQueue.main.async { UIApplication.shared.registerForRemoteNotifications() }
                self.scheduleNotifications()
            }
        }
    }
    
    private func scheduleNotifications() { scheduleReminder(); schedulePromos() }
    
    private func scheduleReminder() {
        var triggerM = Calendar.current.dateComponents([.weekday,.hour,.minute,.second], from: Date())
        triggerM.hour = 20
        triggerM.minute = 0
        triggerM.second = 0
        triggerM.weekday = 1
        
        var triggerW = Calendar.current.dateComponents([.weekday,.hour,.minute,.second], from: Date())
        triggerW.hour = 20
        triggerW.minute = 0
        triggerW.second = 0
        triggerW.weekday = 3
        
        var triggerF = Calendar.current.dateComponents([.weekday,.hour,.minute,.second], from: Date())
        triggerF.hour = 20
        triggerF.minute = 0
        triggerF.second = 0
        triggerF.weekday = 5
        
        var triggerSu = Calendar.current.dateComponents([.weekday,.hour,.minute,.second], from: Date())
        triggerSu.hour = 20
        triggerSu.minute = 0
        triggerSu.second = 0
        triggerSu.weekday = 7
        
        let triggers = [UNCalendarNotificationTrigger(dateMatching: triggerM, repeats: true),
                        UNCalendarNotificationTrigger(dateMatching: triggerW, repeats: true),
                        UNCalendarNotificationTrigger(dateMatching: triggerF, repeats: true),
                        UNCalendarNotificationTrigger(dateMatching: triggerSu, repeats: true)]
        let ids = ["quietReminderMonday",
                   "quietReminderWednesday",
                   "quietReminderFriday",
                   "quietReminderSUnday"]
        
        triggers.enumerated().forEach {
            let content = UNMutableNotificationContent()
            content.title = ""
            content.subtitle = "Time to relax with Quiet"
            content.sound = .default
            
            let request = UNNotificationRequest(identifier: ids[$0.offset],
                                                content: content,
                                                trigger: $0.element)
            
            UNUserNotificationCenter.current().add(request)
        }
    }
    
    private func schedulePromos() {
        var triggerT = Calendar.current.dateComponents([.weekday,.hour,.minute,.second], from: Date())
        triggerT.hour = 20
        triggerT.minute = 0
        triggerT.second = 0
        triggerT.weekday = 2
        
        var triggerTh = Calendar.current.dateComponents([.weekday,.hour,.minute,.second], from: Date())
        triggerTh.hour = 20
        triggerTh.minute = 0
        triggerTh.second = 0
        triggerTh.weekday = 4
        
        var triggerS = Calendar.current.dateComponents([.weekday,.hour,.minute,.second], from: Date())
        triggerS.hour = 20
        triggerS.minute = 0
        triggerS.second = 0
        triggerS.weekday = 6
        
        let triggers = [UNCalendarNotificationTrigger(dateMatching: triggerT, repeats: true),
                        UNCalendarNotificationTrigger(dateMatching: triggerTh, repeats: true),
                        UNCalendarNotificationTrigger(dateMatching: triggerS, repeats: true)]
        let ids = ["quietPromoTuesday",
                   "quietPromoThursday",
                   "quietPromoSaturday"]
        
        triggers.enumerated().forEach {
            let content = UNMutableNotificationContent()
            content.title = ""
            content.subtitle = "We have a special offer for you"
            content.sound = .default
            
            let request = UNNotificationRequest(identifier: ids[$0.offset],
                                                content: content,
                                                trigger: $0.element)
            
            UNUserNotificationCenter.current().add(request)
        }
    }
    
}
