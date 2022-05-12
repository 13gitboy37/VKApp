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
    
    func configureHeader(modelHeader: NewsItems) {
        self.newsAvatarImage.kf.setImage(with: URL(string: "\(modelHeader.avatarURL ?? "")"))
        self.newsName.text = modelHeader.creatorName
    }
}
