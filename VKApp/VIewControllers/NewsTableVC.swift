//
//  NewsTableVC.swift
//  VKApp
//
//  Created by Никита Мошенцев on 19.01.2022.
//

import UIKit

class NewsTableVC: UITableViewController {
   
    private var numRowInSection: Int = 0

    private var newsJSON = [NewsItems]()
    
    var indexPathInTextCell = IndexPath()
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        return dateFormatter
    }()
    
    private var lastDateString: String?
    private var nextFrom = ""
    private var isLoading = false
    
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
    
   private let cellSpacingHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        
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
        }
    
    private func reloadRows(indexPath: IndexPath) {
         self.tableView.reloadRows(at: [indexPath], with: .automatic)
     }
    
    fileprivate func setupRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Обновление...")
        tableView.refreshControl?.tintColor = .blue
        tableView.refreshControl?.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
            }
    
    @objc func refreshNews() {
        guard let date = lastDateString else {
            tableView.refreshControl?.endRefreshing()
            return
        }
        networkService.getUrlWithTime(date)
            .get({ url in
                print(url)
            })
            .then(on: DispatchQueue.global(), networkService.getDataNews(_:))
            .then(on: DispatchQueue.global(), networkService.getParsedDataNews(_:))
            .then(on: .global(), networkService.getNews(_:))
            .done(on: .main) { [weak self] news in
                guard let self = self else { return }
                print(news.count)
                    if news[0].date != self.newsJSON[0].date &&
                       news[0].creatorName != self.newsJSON[0].creatorName &&
                        news[0].text != self.newsJSON[0].text {
                    self.newsJSON.insert(contentsOf: news, at: 0)
                    self.tableView.reloadData()
                    self.lastDateString = String(news.first?.date ?? 0)
                    }
            }.ensure { [weak self] in
                self?.tableView.refreshControl?.endRefreshing()
            }.catch { error in
                print(error)
            }
    }
    
    private func cellStyle(cell: UITableViewCell) {
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.backgroundColor = .brandGrey
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupRefreshControl()
        networkService.getUrlNews()
            .get ({ url in
                print(url)
            })
            .then(on: DispatchQueue.global(), networkService.getDataNews(_:))
            .then(on: .global(), networkService.getParsedDataNews(_:))
            .get({
                self.nextFrom = $0.nextFrom ?? ""
            })
            .then(on: .global(), networkService.getNews(_:))
            .done(on: .main) { [weak self] news in
                self?.newsJSON = news
                self?.tableView.reloadData()
                self?.lastDateString = String(news.first?.date ?? 0)
            } .catch { error in
                print(error)
            }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return newsJSON.count
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         cellSpacingHeight
     }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case typeOfCell.headerCell.rawValue:
            return UITableView.automaticDimension
        case typeOfCell.textCell.rawValue:
            if newsJSON[indexPath.section].text == "" {
            return 0
        }
            return UITableView.automaticDimension
        case typeOfCell.imageCell.rawValue:
            guard let url = newsJSON[indexPath.section].photosURL,
                  !url.isEmpty else { return 0 }
            if url.count == 1 {
            let width = view.frame.width
            let post = newsJSON[indexPath.section]
            let cellHeight = width * post.aspectRatio
            return cellHeight
            } else {
                return UITableView.automaticDimension
            }
        case typeOfCell.footerCell.rawValue:
            return UITableView.automaticDimension
        default: return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let currentNews = newsJSON[indexPath.section]

        switch indexPath.row {
            
        case typeOfCell.headerCell.rawValue:
            guard let cellHeader = tableView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath) as? HeaderCell
         else { return UITableViewCell()}
            
            cellHeader.configureHeader(modelHeader: currentNews)
            cellStyle(cell: cellHeader)
            return cellHeader
            
        case typeOfCell.textCell.rawValue:
                guard let cellTextNews = tableView.dequeueReusableCell(withIdentifier: "textNewsCell", for: indexPath) as? TextNewsCell
                else { return UITableViewCell()}
                
            cellTextNews.configureTextNews(modelTextNews: currentNews, indexPath: indexPath)
            cellTextNews.delegate = self
            cellStyle(cell: cellTextNews)
            
        return cellTextNews
            
        case typeOfCell.imageCell.rawValue:
                guard
                    let cellImageNews = tableView.dequeueReusableCell(withIdentifier: "imagesNewsCell", for: indexPath) as? ImagesNewsCell
                else { return UITableViewCell() }

            cellImageNews.configure(images: currentNews.photosURL ?? [""], aspectRatio: currentNews.aspectRatio)
            cellStyle(cell: cellImageNews)
        return cellImageNews

        case typeOfCell.footerCell.rawValue:
            guard
                let cellFooter = tableView.dequeueReusableCell(withIdentifier: "footerCell", for: indexPath) as? FooterCell
            else { return UITableViewCell()}
            
            cellFooter.configureFooter(modelNumOfViews: currentNews)
            cellStyle(cell: cellFooter)
            
        return cellFooter
            
        default:
            return UITableViewCell()
        }
    }
}

extension NewsTableVC: ShowMoreDelegate {
    func pressShowMore(at indexPath: IndexPath) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

extension NewsTableVC: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxSection = indexPaths.map({ $0.section }).max() else { return }
        
        if maxSection > newsJSON.count - 3,
           !isLoading {
            isLoading = true
            networkService.getUrlNewsInfinity(nextFrom)
                .get ({ url in
                    print(url)
                })
                .then(on: .global(), networkService.getDataNews(_:))
                .then(on: .global(), networkService.getParsedDataNews(_:))
                .get({
                    self.nextFrom = $0.nextFrom ?? ""
                })
                .then(on: .global(), networkService.getNews(_:))
                .done(on: .main) { [weak self] news in
                    guard let self = self else { return }
                    let indexSet = IndexSet(integersIn: self.newsJSON.count..<self.newsJSON.count + news.count)
                    self.newsJSON.append(contentsOf: news)
                    self.tableView.insertSections(indexSet, with: .automatic)
                }.ensure {
                    self.isLoading = false
                } .catch { error in
                    print(error)
                }
        }
    }
}
