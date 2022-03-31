//
//  NewsTableVC.swift
//  VKApp
//
//  Created by Никита Мошенцев on 19.01.2022.
//

import UIKit

class NewsTableVC: UITableViewController {

    var groupNews = [
        "Sport.FM",
        "CS: GO"
    ]
    
    var textNews = [
    "Hello World!",
    "Local Hero"
    ]
    
    let avaNews = [
        "ava.jpg",
        "Avatar2.jpg"
    ]
    
    let imageNews = [
        "https://upload.wikimedia.org/wikipedia/commons/2/23/Supreme-logo-newyork.png",
        "https://besthqwallpapers.com/Uploads/19-11-2018/71930/thumb2-nissan-gt-r-tuning-r35-stance-supercars.jpg"
    ]
    
    let cellSpacingHeight: CGFloat = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(
            nibName: "HeaderCell",
            bundle: nil),
                           forCellReuseIdentifier: "headerCell")
      
        tableView.register(UINib(
            nibName: "FooterCell",
            bundle: nil),
                           forCellReuseIdentifier: "footerCell")
    
        tableView.register(UINib(
            nibName: "TextNewsCell",
            bundle: nil),
                           forCellReuseIdentifier: "textNewsCell")
        
        tableView.register(UINib(
            nibName: "ImageNewsCell",
            bundle: nil),
                           forCellReuseIdentifier: "imageNewsCell")
    }

    // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return groupNews.count
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         cellSpacingHeight
     }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cellHeader = tableView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath) as? HeaderCell
                
                
     else { return UITableViewCell()}
        guard
            let cellTextNews = tableView.dequeueReusableCell(withIdentifier: "textNewsCell", for: indexPath) as? TextNewsCell
        else { return UITableViewCell()}
            
        guard
            let cellImageNews = tableView.dequeueReusableCell(withIdentifier: "imageNewsCell", for: indexPath) as? ImageNewsCell
        else { return UITableViewCell()}
        
        guard
            let cellFooter = tableView.dequeueReusableCell(withIdentifier: "footerCell", for: indexPath) as? FooterCell
        else { return UITableViewCell()}
        
        
        let backgroundColorCell = UIColor.gray.withAlphaComponent(0.1)
        
        let currentGroupNews = groupNews[indexPath.section]
        let currentTextNews = textNews[indexPath.section]
        let currentAvaNews = avaNews[indexPath.section]
        let currentImageNews = imageNews[indexPath.section]
        
        if indexPath.row == 0 {
            
            cellHeader.configureHeader(newsAvatar: UIImage(named: "\(currentAvaNews)") ?? UIImage(), newsGroup: currentGroupNews)
            cellHeader.selectionStyle = UITableViewCell.SelectionStyle.none
            cellHeader.backgroundColor = backgroundColorCell
            
            return cellHeader
        }
        else if indexPath.row == 1 {
            
            cellTextNews.configureTextNews(textNews: currentTextNews)
            cellTextNews.backgroundColor = backgroundColorCell
            cellTextNews.selectionStyle = UITableViewCell.SelectionStyle.none
            
        return cellTextNews
        }
        else if indexPath.row == 2 {
            
            cellImageNews.configureImageNews(imageNews: currentImageNews)
            cellImageNews.selectionStyle = UITableViewCell.SelectionStyle.none
            cellImageNews.backgroundColor = backgroundColorCell
            
            return cellImageNews
        }
        else if indexPath.row == 3{
            
            cellFooter.configureFooter(numOfViews: "236")
            cellFooter.selectionStyle = UITableViewCell.SelectionStyle.none
            cellFooter.backgroundColor = backgroundColorCell
            
            return cellFooter
        }
        
        return UITableViewCell()
    }
}
