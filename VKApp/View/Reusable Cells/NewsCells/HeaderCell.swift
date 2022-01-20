//
//  HeaderCell.swift
//  VKApp
//
//  Created by Никита Мошенцев on 19.01.2022.
//

import UIKit

class HeaderCell: UITableViewCell {
    @IBOutlet var newsAvatarImage: UIImageView!
    @IBOutlet var newsGroupName: UILabel!
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    func configureHeader(newsAvatar: UIImage, newsGroup: String) {
        self.newsAvatarImage.image = newsAvatar
        self.newsGroupName.text = newsGroup
    }
    
}
