//
//  GameCell.swift
//  Raging Bull Casino
//
//  Created by Nutella on 08.12.2021.
//

import UIKit

class GameCell: UICollectionViewCell {
    
    var isAnimated: Bool = false
    
    lazy var iconGame: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon1")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(iconGame)
        
        iconGame.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        iconGame.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        iconGame.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        iconGame.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        iconGame.layer.cornerRadius = 15
        iconGame.layer.masksToBounds = true
        iconGame.layer.borderColor = UIColor.black.cgColor
        iconGame.layer.borderWidth = 1
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
