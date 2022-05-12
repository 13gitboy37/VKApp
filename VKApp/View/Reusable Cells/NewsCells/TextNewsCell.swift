//
//  TextNewsCell.swift
//  VKApp
//
//  Created by Никита Мошенцев on 19.01.2022.
//

import UIKit

class TextNewsCell: UITableViewCell {
    @IBOutlet var textNews: UILabel!
    @IBOutlet var showMore: UIButton!
    
    private var newsText: String? = ""
    private var indexPath = IndexPath()
    var isPressed = false
    var source = NewsTableVC()
    var delegate: ShowMoreDelegate?
    
    @IBAction func pressedShowMore(_ sender: Any) {
        if showMore.titleLabel?.text == "Показать больше..." {
            textNews.numberOfLines = 0
            showMore.setTitle("Скрыть", for: .normal)
            isPressed = true
            source.indexPathInTextCell = self.indexPath
            source.isPressed = self.isPressed
            isPressed.toggle()
        } else {
            textNews.numberOfLines = 4
            showMore.setTitle("Показать больше...", for: .normal)
            isPressed = false
            source.indexPathInTextCell = self.indexPath
            source.isPressed = self.isPressed
            }
                delegate?.pressShowMore(at: indexPath)
    }
    
    func configureTextNews (modelTextNews: NewsItems, indexPath: IndexPath) {
        self.newsText = modelTextNews.text
        if modelTextNews.text?.count ?? 0 <= 200 {
            self.textNews.numberOfLines = 0
            self.showMore.isHidden = true
        } else {
            self.textNews.numberOfLines = 4
            self.showMore.isHidden = false
        }
        self.textNews.text = modelTextNews.text
        self.indexPath = indexPath
    }
}

