//
//  GroupsCell.swift
//  VKApp
//
//  Created by Никита Мошенцев on 25.12.2021.
//

import UIKit
import Kingfisher

final class GroupsCell: UITableViewCell {
    @IBOutlet var groupsEmblem: UIImageView!
    @IBOutlet var groupsName: UILabel!
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
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
    
    func configure(model: GroupsItems) {
        self.groupsName.text = model.name
        self.groupsEmblem.kf.setImage(with: URL(string: model.groupsPhoto), placeholder: UIImage(systemName: "rectangle.3.group.bubble.left"))
    }
}


