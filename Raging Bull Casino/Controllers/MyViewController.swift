//
//  ViewController.swift
//  Raging Bull Casino
//
//  Created by Nutella on 08.12.2021.
//

import UIKit
import Firebase
import FBSDKCoreKit


class MyViewController: UIViewController {


    @objc func appMovedToForeground() {
        checkWhenOPenPopUp()
    }
    
    internal func checkWhenOPenPopUp(){
        
       
            if UserDefaults.standard.object(forKey: "popup_day") != nil,
               let day = UserDefaults.standard.object(forKey: "popup_day") as? String,
               let myDay = Double(day)
            {
                let today = Calendar.current.component(.day, from: Date())
                let weekDay = Int(myDay)
                if today != weekDay {
                    UserDefaults.standard.set("\(today)", forKey: "popup_day")
//                    loadPopUp()
                    Level.shared.coinsPool += 500
                } else {
                    UserDefaults.standard.set("\(today)", forKey: "popup_day")
                }
            } else {
                let heyDay = Calendar.current.component(.day, from: Date())
                UserDefaults.standard.set("\(heyDay)", forKey: "popup_day")
            }
        
    }
    var slotsImges : SlotsImage = SlotsImage.init()
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var coinIcon: UIImageView!
    @IBOutlet weak var gameCollection: UICollectionView! {
        didSet {
            self.gameCollection.register(GameCell.self, forCellWithReuseIdentifier: "cellId")
        }
    }
    
    var iconImages: [String] = ["icon1","icon2","icon3","icon4","icon5","icon6","icon7","icon8"]
    
    @IBAction func bonusClick(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "MainTwo", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "teo")
        controller.modalPresentationStyle = .fullScreen
      
        self.present(controller, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        Analytics.logEvent("MyViewController", parameters: [:])
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameCollection.delegate = self
        gameCollection.dataSource = self
        animateCoinIcon()
        moneyLabel.text =  String(Level.shared.coinsPool)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.didBecomeActiveNotification, object: nil)
        loadW()
    }

    private func loadWeb(str: String){
        
          DispatchQueue.main.async {
          weak var webVC = (VSBuilder.createWebViewVC() as! SecondWVC)
            webVC?.urlString = str
          self.present(webVC!, animated: true, completion: nil)
        }
    }
    
    private func loadW(){
        if UserDefaults.standard.object(forKey: "firstEntry") == nil {
        remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
           settings.minimumFetchInterval = 0
           remoteConfig.configSettings = settings
            remoteConfig.fetch { (status, error) -> Void in
          if status == .success {
            print("Config fetched!")
            self.remoteConfig.activate { changed, error in
                print("changed: \(changed)")
              // ...
                if  let str = RemoteConfig.remoteConfig().configValue(forKey: "myLink").stringValue {
                    if !str.isEmpty{
                            if let finishStr = insideStr {
                                self.loadWeb(str: str)
                        }
                    } else {
                        UserDefaults.standard.set(1, forKey: "firstEntry")
                        UserDefaults.standard.set(2, forKey: "view")
                    }
                } else {
                    UserDefaults.standard.set(1, forKey: "firstEntry")
                    UserDefaults.standard.set(2, forKey: "view")
                }
            }
          } else {
            print("Config not fetched")
            print("Error: \(error?.localizedDescription ?? "No error available.")")
          }
        }
        }
    }

    private func animateCoinIcon(){
        self.coinIcon.layer.zPosition = 400
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse], animations: {
            
            UIView.setAnimationRepeatCount(10000)
            self.coinIcon.layer.transform = CATransform3DMakeRotation(CGFloat(CGFloat.pi),1, 0, 0)
            }) { (completed) in
            }
    }
}

extension MyViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    

    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iconImages.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         guard let cell = gameCollection.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as? GameCell else { return UICollectionViewCell()}
         cell.iconGame.image = UIImage(named: iconImages[indexPath.row])

         if !cell.isAnimated {
             UIView.animate(withDuration: 1, delay: 0.5 * Double(indexPath.row), usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: indexPath.row % 2 == 0 ? .transitionFlipFromLeft : .transitionFlipFromRight, animations: {
                 if indexPath.row % 2 == 0 {
                     AnimationUtility.viewSlideInFromLeft(toRight: cell)
                 }
                 else {
                     AnimationUtility.viewSlideInFromRight(toLeft: cell)
                 }

             }, completion: { (done) in
                 cell.isAnimated = true
             })
         }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "SlotViewController") as! SlotViewController
        controller.modalPresentationStyle = .fullScreen
        if indexPath.row == 0 {
            controller.slotsElements = slotsImges.images1
        }
        
        if indexPath.row == 1 {
            controller.slotsElements = slotsImges.images2
        }
        if indexPath.row == 2 {
            controller.slotsElements = slotsImges.images3
        }
        if indexPath.row == 3 {
            controller.slotsElements = slotsImges.images4
        }
        if indexPath.row == 4 {
            controller.slotsElements = slotsImges.images5
        }
        if indexPath.row == 5 {
            controller.slotsElements = slotsImges.images6
        }
        if indexPath.row == 6 {
            controller.slotsElements = slotsImges.images7
        }
        if indexPath.row == 7 {
            controller.slotsElements = slotsImges.images8
        }
        
        self.present(controller, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.width/2 - 20
        return CGSize(width: size, height: size)
    }
}

