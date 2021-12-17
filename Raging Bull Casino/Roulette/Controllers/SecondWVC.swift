//
//  SecondWVC.swift
//  Crown Melbourne
//
//  Created by a.pyvovarov on 30.07.2021.
//

import UIKit
import WebKit
import SafariServices
import AdSupport
import Firebase
import FBSDKCoreKit

class SecondWVC: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    //MARK: - IBOutlets
    @IBOutlet weak var secondWebView: WKWebView!
    @IBOutlet weak var loadingInficator: UIActivityIndicatorView!
    
    //MARK: - private params
    var urlString: String = ""
    
  
    
    
    
    var stringUrl = ""
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        secondWebView.navigationDelegate = self
        secondWebView.scrollView.isScrollEnabled = true
        self.secondWebView.uiDelegate = self
          var userAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 11_2_6 like Mac OS X) AppleWebKit/604.5.6 (KHTML, like Gecko) Version/11.0 Mobile/15D100 Safari/604.1"
         
         if #available(iOS 13.0, *){
             userAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 13_1_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.1 Mobile/15E148 Safari/604.1"
         } else {
             userAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 11_2_6 like Mac OS X) AppleWebKit/604.5.6 (KHTML, like Gecko) Version/11.0 Mobile/15D100 Safari/604.1"
         }
        if UserDefaults.standard.object(forKey: "firstDeep") == nil {
            UserDefaults.standard.set(1, forKey: "firstDeep")
            loadingInficator.startAnimating()
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [self] in
                loadingInficator.stopAnimating()
                if let encoded = self.formingUrlString().addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed){
                    if let url = URL(string: encoded) {
                        let request = URLRequest(url: url)
                        secondWebView.customUserAgent = userAgent
                        self.secondWebView.load(request)
                    }
                }
            }
        } else {
            if let encoded = self.formingUrlString().addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed){
                if let url = URL(string: encoded) {
                    let request = URLRequest(url: url)
                    secondWebView.customUserAgent = userAgent
                    self.secondWebView.load(request)
                }
            }
        }
        setToolBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        Analytics.logEvent("SecondViewController", parameters: [:])
        self.secondWebView.frame   = CGRect(x: 0, y: 0, width: self.view.frame.width,
        height: self.view.frame.height)
    }
    

    //MARK:- Private functions
       private func formingUrlString() -> String{
//                if (UserDefaults.standard.object(forKey: "saveReferrerr")) != nil {
//                    return (UserDefaults.standard.object(forKey: "saveReferrerr") as! String)
//                }
        if (UserDefaults.standard.object(forKey: "mainString")) != nil {
            urlString = UserDefaults.standard.object(forKey: "mainString") as! String

        }
           if (UserDefaults.standard.object(forKey: "referrer1")) != nil {
               let  diplink = UserDefaults.standard.object(forKey: "referrer1") as! String
            if urlString.contains("?"){
                return urlString + "&" + diplink
            } else {
                return urlString + "?" + diplink
            }
           } else {
            return urlString
        }
        
       }

    lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    fileprivate func setToolBar() {

        secondWebView.addSubview(backButton)
    // Constraints
        backButton.bottomAnchor.constraint(equalTo: secondWebView.bottomAnchor, constant: 0).isActive = true
        backButton.leadingAnchor.constraint(equalTo: secondWebView.leadingAnchor, constant: 0).isActive = true
        backButton.backgroundColor = UIColor.clear
        
        backButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
      }
      @objc private func goBack() {
        if secondWebView.canGoBack {
          secondWebView.goBack()
        } else {
          self.dismiss(animated: true, completion: nil)
        }
      }
}

extension SecondWVC {
    //MARK: - WebView delegate
   
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
           if navigationAction.targetFrame == nil {
               webView.load(navigationAction.request)
           }
           return nil
       }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        loadingInficator.startAnimating()
        secondWebView.isHidden = false
        if let str = webView.url?.absoluteString {
            print(str)
            if !str.contains("ggplayson"){
                UserDefaults.standard.set(str, forKey: "saveReferrerr")
            }

        }
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
       
        if let str = navigationAction.request.url?.absoluteString {
            var userAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 11_2_6 like Mac OS X) AppleWebKit/604.5.6 (KHTML, like Gecko) Version/11.0 Mobile/15D100 Safari/604.1"

           if #available(iOS 13.0, *){
               userAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 13_1_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.1 Mobile/15E148 Safari/604.1"
           } else {
               userAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 11_2_6 like Mac OS X) AppleWebKit/604.5.6 (KHTML, like Gecko) Version/11.0 Mobile/15D100 Safari/604.1"
           }
//            print(str)
            if !str.contains("ggplayson"){
                if (UserDefaults.standard.object(forKey: "referrer2")) != nil {
                    if (UserDefaults.standard.object(forKey: "entryFirst")) == nil {
                        UserDefaults.standard.set(1, forKey: "entryFirst")
                        let  diplink1 = UserDefaults.standard.object(forKey: "referrer2") as! String
                        if str.contains("?"){

                            let str3 = str + "&" + diplink1
                            if let encoded = str3.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed){
                                if let url = URL(string: encoded) {
                                    let request = URLRequest(url: url)
                                    webView.customUserAgent = userAgent
                                    webView.load(request)
                                    decisionHandler(.cancel)
                                }
                            }
                        } else {
                            let str3 = str + "?" + diplink1
                            if let encoded = str3.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed){
                                if let url = URL(string: encoded) {
                                    let request = URLRequest(url: url)
                                    webView.customUserAgent = userAgent
                                    webView.load(request)
                                    decisionHandler(.cancel)
                                }
                            }
                        }

                    } else {
                        decisionHandler(.allow)
                    }
                } else {
                    decisionHandler(.allow)
                }
            } else {
                decisionHandler(.allow)
            }
        } else {
            decisionHandler(.allow)
        }
    }


    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingInficator.stopAnimating()


    }
}
