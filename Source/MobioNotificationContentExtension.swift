//
//  MobioNotificationContentExtension.swift
//  MobioRichNotification
//
//  Created by Sun on 04/08/2022.
//

import UIKit
import UserNotificationsUI

open class MobioNotificationContentExtension: UIViewController, UNNotificationContentExtension {
    
    var viewController: BaseNotificationContentViewController!
    
    open func didReceive(_ notification: UNNotification) {
        if let aps = notification.request.content.userInfo["aps"] as? [String : Any],
           let richView = aps["rich_view"] as? String {
            if richView == "one" {
                viewController = SlideViewController.instantiate()
            }
            viewController.view.frame = view.frame
            view.addSubview(viewController.view)
        }
        preferredContentSize.height = 300
    }
    
    public func didReceive(_ response: UNNotificationResponse,
                           completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        completion(viewController.handleAction(response: response))
    }
}
