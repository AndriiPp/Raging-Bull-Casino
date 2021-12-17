//
//  AboutViewController.swift
//  Raging Bull Casino
//
//  Created by Nutella on 17.12.2021.
//

import UIKit
import Firebase
import FBSDKCoreKit
class AboutViewController: UIViewController {

    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    @IBOutlet weak var apkVersionLbl: UILabel!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        Analytics.logEvent("AboutViewController", parameters: [:])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        apkVersionLbl.text = "App Version : "+"\(appVersion!)"
    }
    
    @IBAction func backActiob(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
