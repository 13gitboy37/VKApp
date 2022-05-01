//
//  HeaderCell.swift
//  VKApp
//
//  Created by Никита Мошенцев on 19.01.2022.
//

import UIKit
import Kingfisher


class HeaderCell: UITableViewCell {
    @IBOutlet var newsAvatarImage: UIImageView!
    @IBOutlet var newsName: UILabel!
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    func configureHeader(newsAvatar: String, newsGroup: String) {
        self.newsAvatarImage.kf.setImage(with: URL(string: "\(newsAvatar)"))
        self.newsName.text = newsGroup
    }
    
    func configureHeaderForGroups(modelHeader: NewsGroups) {
        self.newsAvatarImage.kf.setImage(with: URL(string: "\(modelHeader.photo)"))
        self.newsName.text = modelHeader.name
    }
    
    func configureHeaderForProfiles(modelHeader: NewsProfiles) {
        self.newsAvatarImage.kf.setImage(with: URL(string: "\(modelHeader.photo)"))
        self.newsName.text = modelHeader.lastName + " " + modelHeader.firstName
    }
}
