//
//  PhotoFriendsCollectionCell.swift
//  VKApp
//
//  Created by Никита Мошенцев on 26.12.2021.
//

import UIKit
import Kingfisher

final class PhotoFriendsCollectionCell: UICollectionViewCell {
    
    @IBOutlet var photoFriend: UIImageView!
    @IBOutlet var buttonLike: UIButton!
    
    @IBAction func pressedLike(_ sender: Any) {
        if buttonLike.titleLabel?.text == "0" {
        buttonLike.setImage(UIImage(systemName: "heart.fill"), for: .normal)
 //           buttonLike.setTitle("1", for: .normal)
            animateLikeButton()
        }
            else {
                buttonLike.setImage(UIImage(systemName: "heart"), for: .normal)
                animateDislikeButton()
            }
    }
    
    func configure(photoFr: UIImage?) {
        self.photoFriend.image = photoFr
        
    }
    
    func configure(model: PhotosItems) {
        self.photoFriend.kf.setImage(with: URL(string: model.sizes.last!.urlPhoto), placeholder: UIImage(systemName: "person.fill"))
    }
    
    func configure(model: RealmPhoto) {
        self.photoFriend.kf.setImage(with: URL(string: model.urlPhoto), placeholder: UIImage(systemName: "person.fill"))
    }
    
    func animateLikeButton() {
        UIView.transition(
            with: buttonLike,
            duration: 0.5,
            options: .transitionFlipFromLeft,
            animations: {
                self.buttonLike.setTitle("1", for: .normal)
            })
    }
    
    func animateDislikeButton() {
        UIView.transition(
            with: buttonLike,
            duration: 0.5,
            options: .transitionFlipFromRight,
            animations: {
                self.buttonLike.setTitle("0", for: .normal)
            })
        }    
}
