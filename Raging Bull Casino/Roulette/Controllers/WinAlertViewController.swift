//
//  WinAlertViewController.swift
//  Raging Bull Casino
//
//  Created by Nutella on 17.12.2021.
//


import UIKit
import Firebase
import FBSDKCoreKit

class WinAlertViewController: UIViewController {
    var time = 6
    var timer = Timer()
    var winPrice = ""
    @IBOutlet weak var priceLbl: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        Analytics.logEvent("WinAlertViewController", parameters: [:])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        priceLbl.text = winPrice
        callTimer()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    func callTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(WinAlertViewController.action)), userInfo: nil, repeats: true)
    }
    
    @objc func action(){
        time -= 1
        if time == 3{
            self.dismiss(animated: true, completion: nil)
            timer.invalidate()
        }
    }

}
