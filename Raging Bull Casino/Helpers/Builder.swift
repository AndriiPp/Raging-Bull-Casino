//
//  Builder.swift
//  Raging Bull Casino
//
//  Created by Nutella on 17.12.2021.
//

import UIKit

//MARK: - ViewController creator
class VSBuilder {

    class func createWebViewVC() -> UIViewController{
        let storyboard = UIStoryboard(name: "SecondStoryboard", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SecondWebStory")
        controller.modalPresentationStyle = .fullScreen
        return controller
    }
}
