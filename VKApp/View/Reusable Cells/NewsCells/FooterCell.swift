//
//  FooterCell.swift
//  VKApp
//
//  Created by Никита Мошенцев on 19.01.2022.
//

import UIKit

class FooterCell: UITableViewCell {
    
    @IBOutlet var buttonLikeNews: UIButton!
    @IBOutlet var buttonCommentNews: UIButton!
    @IBOutlet var numOfViewsNews: UILabel!
    @IBOutlet var buttonRepostNews: UIButton!
    
    
    @IBAction func pressedLikeNews(_ sender: Any) {
     if buttonLikeNews.titleLabel?.text == "0" {
        buttonLikeNews.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            buttonLikeNews.setTitle("1", for: .normal)
        }
            else {
                buttonLikeNews.setImage(UIImage(systemName: "heart"), for: .normal)
                buttonLikeNews.setTitle("0", for: .normal)
            }
    }
     
    func configureFooter(numOfViews: String) {
        self.numOfViewsNews.text = numOfViews
    }
    
}
