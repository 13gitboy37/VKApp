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
}
