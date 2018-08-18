//
//  ModalViewViewController.swift
//  LTios
//
//  Created by Paul Bénéteau on 16/08/2018.
//  Copyright © 2018 Tastyapp. All rights reserved.
//

import UIKit

class ModalViewViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
    }
}
