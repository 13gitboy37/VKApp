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
}
