//
//  GroupsCell.swift
//  VKApp
//
//  Created by Никита Мошенцев on 25.12.2021.
//

import UIKit

final class GroupsCell: UITableViewCell {
    @IBOutlet var groupsEmblem: UIImageView!
    @IBOutlet var groupsName: UILabel!
    
    func configure(
        emblem: UIImage,
        name: String) {
            self.groupsEmblem.image = emblem
            self.groupsName.text = name
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
                self.groupsEmblem.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            } completion: { _ in
                self.groupsEmblem.transform = .identity
        }
        
    }
}

