//
//  FriendsCell.swift
//  VKApp
//
//  Created by Никита Мошенцев on 24.12.2021.
//

import UIKit

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
        emblem: UIImage,
        name: String) {
            self.friendsEmblem.image = emblem
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
}
