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
    
    var indexPathInTextCell = IndexPath()
    
    var isPressed = false {
        didSet{
            reloadRows(indexPath: indexPathInTextCell)
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
    
    func reloadRows(indexPath: IndexPath) {
//        DispatchQueue.main.async {
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
//            self.tableView.reloadData()
//        }
    }
    
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
        
            self.networkService.getNews() { [weak self] result in
                switch result {
                case .success(let news):
                    DispatchQueue.main.async {
                        self?.newsJSON = news
                    }
                case .failure(let error):
                    print(error)
                }
            }
    
            self.networkService.getNewsProfiles() { [weak self] result in
            switch result {
            case .success(let profiles):
                DispatchQueue.main.async {
                    self?.profilesNews = profiles
                }
            case .failure(let error):
                print(error)
                }
            }
    
            self.networkService.getNewsGroups() { [weak self] result in
                switch result {
                case .success(let groups):
                    DispatchQueue.main.async {
                        self?.groupsNews = groups
                    }
                case .failure(let error):
                    print(error)
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
                
            cellTextNews.configureTextNews(modelTextNews: currentNews, indexPath: indexPath)
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
                
            } else {
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
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(1)
//        tableView.reloadRows(at: [indexPath], with: .none)
//    }
}

extension NewsTableVC: ShowMoreDelegate {
    func pressShowMore(at indexPath: IndexPath) {
        self.tableView.reloadRows(at: [indexPath], with: .fade)
    }
}
/*
 VKApp[21234:559189] [TableView] Warning once only: UITableView was told to layout its visible cells and other contents without being in the view hierarchy (the table view or one of its superviews has not been added to a window). This may cause bugs by forcing views inside the table view to load and perform layout without accurate information (e.g. table view bounds, trait collection, layout margins, safe area insets, etc), and will also cause unnecessary performance overhead due to extra layout passes. Make a symbolic breakpoint at UITableViewAlertForLayoutOutsideViewHierarchy to catch this in the debugger and see what caused this to occur, so you can avoid this action altogether if possible, or defer it until the table view has been added to a window. Table view: <UITableView: 0x13301b200; frame = (0 0; 0 0); clipsToBounds = YES; autoresize = W+H; gestureRecognizers = <NSArray: 0x60000169eb20>; layer = <CALayer: 0x6000018ca180>; contentOffset: {0, 0}; contentSize: {0, 1496}; adjustedContentInset: {0, 0, 0, 0}; dataSource: <_UIFilteredDataSource: 0x6000016a4ea0>>
 */
