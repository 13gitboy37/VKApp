//
//  TextNewsCell.swift
//  VKApp
//
//  Created by Никита Мошенцев on 19.01.2022.
//

import UIKit

class TextNewsCell: UITableViewCell {
    @IBOutlet var textNews: UILabel!
    
    func configureTextNews (textNews: String) {
        self.textNews.text = textNews
    }
    func configureTextNews (modelTextNews: NewsModel) {
        self.textNews.text = modelTextNews.textNews
    }
    
    func configureTextNews (modelTextNews: NewsItems) {
        self.textNews.numberOfLines = 0
        self.textNews.text = modelTextNews.text
    }
}
