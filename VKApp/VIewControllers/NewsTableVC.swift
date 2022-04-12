//
//  NewsTableVC.swift
//  VKApp
//
//  Created by Никита Мошенцев on 19.01.2022.
//

import UIKit

class NewsTableVC: UITableViewController {
    
    var numRowInSection: Int = 0
    
    var groupsNews = [NewsGroups]() {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    var profilesNews = [NewsProfiles]() {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }


    var newsJSON = [NewsItems]() {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    private let networkService = NetworkService()
    
    enum typeOfCell: Int {
        case headerCell = 0
        case textCell = 1
        case imageCell = 2
        case footerCell = 3
    }
    
    let cellSpacingHeight: CGFloat = 0
    
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
            nibName: "ImagesNewsCell",
            bundle: nil),
                           forCellReuseIdentifier: "imagesNewsCell")
        
        DispatchQueue.global().async {
            self.networkService.getNews() { [weak self] result in
                switch result {
                case .success(let news):
                        self?.newsJSON = news
                case .failure(let error):
                    print(error)
                }
            }
        }
    
        DispatchQueue.global().async {
            self.networkService.getNewsProfiles() { [weak self] result in
            switch result {
            case .success(let profiles):
                    self?.profilesNews = profiles
            case .failure(let error):
                print(error)
                }
            }
        }
        
        DispatchQueue.global().async {
            self.networkService.getNewsGroups() { [weak self] result in
                switch result {
                case .success(let groups):
                        self?.groupsNews = groups
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
        

    // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.newsJSON[section].attachments?.first?.photo != nil && self.newsJSON[section].text != "" {
            self.numRowInSection = 4
            return numRowInSection
        } else {
            self.numRowInSection = 3
            return numRowInSection
        }
}
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return newsJSON.count
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         cellSpacingHeight
     }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
   
        
        let currentNews = newsJSON[indexPath.section]
        
        var images = [String?]()
        images.removeAll()
        
        currentNews.attachments?.forEach({ index in
            if index.photo != nil {
                guard let currentImage = index.photo?.sizes.last?.url else {return}
                images.append(currentImage)
            }
        })
        
                 
        let backgroundColorCell = UIColor.gray.withAlphaComponent(0.1)

        switch indexPath.row {
            
        case typeOfCell.headerCell.rawValue:
            guard
                let cellHeader = tableView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath) as? HeaderCell
         else { return UITableViewCell()}
            
            if currentNews.sourceID > 0 {
                for newsProfile in self.profilesNews where currentNews.sourceID == newsProfile.id {
                    cellHeader.configureHeaderForProfiles(modelHeader: newsProfile)
                }
            } else {
                for newsGroup in self.groupsNews where abs(currentNews.sourceID) == newsGroup.id {
                    cellHeader.configureHeaderForGroups(modelHeader: newsGroup)
                }
            }
            
            cellHeader.selectionStyle = UITableViewCell.SelectionStyle.none
            cellHeader.backgroundColor = backgroundColorCell
            
            return cellHeader
            
        case typeOfCell.textCell.rawValue:
            
            if currentNews.text != "" {
                guard
                    let cellTextNews = tableView.dequeueReusableCell(withIdentifier: "textNewsCell", for: indexPath) as? TextNewsCell
                else { return UITableViewCell()}
                
            cellTextNews.configureTextNews(modelTextNews: currentNews)
            cellTextNews.backgroundColor = backgroundColorCell
            cellTextNews.selectionStyle = UITableViewCell.SelectionStyle.none
            
        return cellTextNews
                
            } else {
                
                fallthrough

            }
            
        case typeOfCell.imageCell.rawValue:
            
            if indexPath.row == 2 && currentNews.text == "" {

                fallthrough
                
            } else if images.count != 0 {

                guard
                    let cellImageNews = tableView.dequeueReusableCell(withIdentifier: "imagesNewsCell", for: indexPath) as? ImagesNewsCell
                else { return UITableViewCell() }

                cellImageNews.configure(images: images)
                                    

        cellImageNews.selectionStyle = UITableViewCell.SelectionStyle.none
        cellImageNews.backgroundColor = backgroundColorCell
        
        return cellImageNews
                
            }
            else {
                fallthrough
            }

        case typeOfCell.footerCell.rawValue:
            guard
                let cellFooter = tableView.dequeueReusableCell(withIdentifier: "footerCell", for: indexPath) as? FooterCell
            else { return UITableViewCell()}
            
            cellFooter.configureFooter(modelNumOfViews: currentNews)
            cellFooter.selectionStyle = UITableViewCell.SelectionStyle.none
            cellFooter.backgroundColor = backgroundColorCell
            
        return cellFooter
            
        default:
            return UITableViewCell()
        }
    }
}
