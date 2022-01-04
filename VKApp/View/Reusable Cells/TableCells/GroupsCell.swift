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
}
