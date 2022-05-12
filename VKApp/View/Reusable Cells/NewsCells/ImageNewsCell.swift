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
  
    func configureImageNews(modelImageNews: NewsModel) {
        modelImageNews.imageNews?.forEach({ imageNews in
            self.imageNews.kf.setImage(with: URL(string: imageNews))
        })
    }
}
