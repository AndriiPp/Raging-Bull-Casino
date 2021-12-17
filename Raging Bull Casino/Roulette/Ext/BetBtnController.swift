//
//  BetBtnController.swift
//  Raging Bull Casino
//
//  Created by Nutella on 17.12.2021.
//


import Foundation
import UIKit

protocol BetBtnControllerProtocol {
    func betButtonAction(type: String!, button: UIButton!)
}

class BetBtnController : UIView {
    
    var betDelegate : BetBtnControllerProtocol!
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var btn: UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initXib()
    }
    
    private func initXib() {
        let nib = UINib.init(nibName: "BetBtn", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    func setBoder(){
        mainView.layer.borderWidth = 1
        mainView.layer.borderColor = UIColor.white.cgColor
    }
    func changeButtonName(txt: String!){
        btn.setTitle(txt, for: .normal)
        setBoder()
    }
    
    func setBackgroundColor(color: UIColor){
        btn.backgroundColor = color
        setBoder()
    }
    
    @IBAction func btnAction(_ sender: Any) {
        if btn.titleLabel?.text! != "" {
            betDelegate.betButtonAction(type: btn.titleLabel?.text!,button: btn)
        }
        
    }
}
