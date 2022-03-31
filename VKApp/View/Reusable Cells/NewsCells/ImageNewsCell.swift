//
//  ImageNewsCell.swift
//  VKApp
//
//  Created by Никита Мошенцев on 19.01.2022.
//

import UIKit
import Kingfisher

class ImageNewsCell: UITableViewCell {
    
    @IBOutlet var imageNews: UIImageView!
  
    
    func configureImageNews(imageNews: UIImage) {
        self.imageNews.image = imageNews
    }
    
    func configureImageNews(imageNews: String) {
        self.imageNews.kf.setImage(with: URL(string: imageNews))
    }
}
