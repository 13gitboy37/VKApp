//
//  PhotoFriendsCollectionCell.swift
//  VKApp
//
//  Created by Никита Мошенцев on 26.12.2021.
//

import UIKit

final class PhotoFriendsCollectionCell: UICollectionViewCell {
    
    @IBOutlet var photoFriend: UIImageView!
    @IBOutlet var buttonLike: UIButton!
    
    @IBAction func pressedLike(_ sender: Any) {
        if buttonLike.titleLabel?.text == "0" {
        buttonLike.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            buttonLike.setTitle("1", for: .normal)
        }
            else {
                buttonLike.setImage(UIImage(systemName: "heart"), for: .normal)
                buttonLike.setTitle("0", for: .normal)
            }
    }
    
    
    
    func configure(photoFr: UIImage?) {
        self.photoFriend.image = photoFr
        
    }
    
}
