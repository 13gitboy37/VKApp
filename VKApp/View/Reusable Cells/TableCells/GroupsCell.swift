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
    
    // Configure for personal groups
    func configure(model: RealmGroup) {
        self.groupsName.text = model.name
        self.groupsEmblem.kf.setImage(with: URL(string: model.groupsPhoto))
    }
    
    func configure(model: GroupViewModel) {
        self.groupsName.text = model.groupText
        self.groupsEmblem.kf.setImage(with: URL(string: model.iconGroupImage))
    }
    
    // Configure for search groups
    func configure(model: RealmSearchGroup) {
        self.groupsName.text = model.name
        self.groupsEmblem.kf.setImage(with: URL(string: model.groupsPhoto))
    }

}


