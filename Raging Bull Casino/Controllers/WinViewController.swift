//
//  WinViewController.swift
//  Raging Bull Casino
//
//  Created by Nutella on 16.12.2021.
//


import UIKit
import Firebase
import FBSDKCoreKit

class WinViewController: UIViewController {
    
    @IBOutlet weak var NumberOfWonChips: UILabel!
    
    var wonChipsLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        Analytics.logEvent("WinViewController", parameters: [:])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NumberOfWonChips.text = wonChipsLabel.text
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
