//
//  BaseNotificationContentViewController.swift
//  MobioSDKSwift
//
//  Created by Sun on 15/08/2022.
//

import UIKit
import UserNotificationsUI

protocol NotificationContentViewControllerType {
    
    func handleAction(response: UNNotificationResponse) -> UNNotificationContentExtensionResponseOption
    func configureUserNotificationsCenter()
}

class BaseNotificationContentViewController: UIViewController, XibSceneBased {
    
    @objc dynamic func handleAction(response: UNNotificationResponse) -> UNNotificationContentExtensionResponseOption {
        return .doNotDismiss
    }
    
    @objc dynamic func configureUserNotificationsCenter() {
    }
}
