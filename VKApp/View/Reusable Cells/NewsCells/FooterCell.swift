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
    
    var numOfLikes = Int()
    var numOfRepost = Int()
    var numOfComments = Int()
    
    func setNums() {
        self.buttonLikeNews.setTitle("\(self.numOfLikes)", for: .normal)
        self.buttonCommentNews.setTitle("\(self.numOfComments)", for: .normal)
        self.buttonRepostNews.setTitle("\(self.numOfRepost)", for: .normal)
    }
   
    
    @IBAction func pressedLikeNews(_ sender: Any) {
     if buttonLikeNews.titleLabel?.text == "\(numOfLikes)" {
        buttonLikeNews.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            buttonLikeNews.setTitle("\(numOfLikes + 1)", for: .normal)
        }
            else {
                buttonLikeNews.setImage(UIImage(systemName: "heart"), for: .normal)
                buttonLikeNews.setTitle("\(numOfLikes)", for: .normal)
            }
    }
     
    func configureFooter(modelNumOfViews: NewsItems) {
        numOfLikes = modelNumOfViews.likes.likesCount
        numOfRepost = modelNumOfViews.reposts.repostsCount
        numOfComments = modelNumOfViews.comments.commentsCount
        self.numOfViewsNews.text = "\(modelNumOfViews.views?.viewsCount ?? 0)"
        setNums()
    }
    
}
