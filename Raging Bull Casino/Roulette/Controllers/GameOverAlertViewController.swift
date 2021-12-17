//
//  GameOverAlertViewController.swift
//  Raging Bull Casino
//
//  Created by Nutella on 17.12.2021.
//


import UIKit
import Firebase
import FBSDKCoreKit

protocol gameOverProtoCol {
    func resetAgain()
}

class GameOverAlertViewController: UIViewController {

    var delegate : gameOverProtoCol?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        Analytics.logEvent("GameOverViewController", parameters: [:])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    @IBAction func action(_ sender: Any) {
        delegate?.resetAgain()
        dismiss(animated: true, completion: nil)
    }
}
