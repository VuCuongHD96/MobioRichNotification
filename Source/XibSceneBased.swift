//
//  XibSceneBased.swift
//  MobioRichNotification
//
//  Created by Sun on 04/08/2022.
//

import UIKit

public protocol XibSceneBased where Self: UIViewController {
}

extension XibSceneBased {
    
    public static func instantiate() -> Self {
        let bundle = Bundle(for: Self.self)
        let nibName = String(describing: Self.self)
        let viewController = Self(nibName: nibName, bundle: bundle)
        return viewController
    }
}
