//
//  MobioNotificationContentExtension.swift
//  MobioRichNotification
//
//  Created by Sun on 04/08/2022.
//

import UIKit
import UserNotificationsUI

open class MobioNotificationContentExtension: UIViewController, UNNotificationContentExtension {
    
    let slideViewController = SlideViewController.instantiate()
    
    open func didReceive(_ notification: UNNotification) {
        if let notifContentView = slideViewController.view {
            notifContentView.frame = view.bounds
            view.addSubview(notifContentView)
        }
    }
}
