//
//  ViewController.swift
//  Example
//
//  Created by Sun on 04/08/2022.
//

import UIKit
import MobioRichNotification

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let vc = SlideViewController.instantiate()
        present(vc, animated: true, completion: nil)
    }
}
