//
//  FriendsCell.swift
//  VKApp
//
//  Created by Никита Мошенцев on 24.12.2021.
//

import UIKit
import Kingfisher

class FriendsCell: UITableViewCell {
    

    @IBOutlet var friendsName: UILabel!
    @IBOutlet var friendsEmblem: UIImageView!
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    func configure (
        emblem: String,
        name: String) {
            self.friendsEmblem.kf.setImage(with: URL(string: emblem))
            self.friendsName.text = name
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        animateImage()
        super.touchesBegan(touches, with: event)
        }
    
    func animateImage() {
        UIView.animate(
            withDuration: 0.7,
            delay: .zero,
            usingSpringWithDamping: 0.1,
            initialSpringVelocity: 1.0) {
                self.friendsEmblem.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            } completion: { _ in
                self.friendsEmblem.transform = .identity
        }
       
    }
    
 //config wit model
    func configure(model: UserItems) {
        self.friendsName.text = model.lastName + " " + model.firstName
        self.friendsEmblem.kf.setImage(with: URL(string: model.userPhoto))
    }


    func configure(model: RealmUser) {
        self.friendsName.text = model.lastName + " " + model.firstName
        self.friendsEmblem.kf.setImage(with: URL(string: model.userPhoto))
    }
}

