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

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cellHeader = tableView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath) as? HeaderCell
                
        //    let cellFooter = tableView.dequeueReusableCell(withIdentifier: "footerCell", for: indexPath) as? FooterCell
                
           // let cellText = tableView.dequeueReusableCell(withIdentifier: "Text News", for: indexPath) as? TextNewsCell
                
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
        
    //MARK: Поправить после теста
        let currentGroupNews = groupNews[indexPath.section]
        let currentTextNews = textNews[indexPath.section]
        
        if indexPath.row == 0 {
        cellHeader.configureHeader(newsAvatar: UIImage(systemName: "lasso") ?? UIImage(), newsGroup: currentGroupNews)
            cellHeader.selectionStyle = UITableViewCell.SelectionStyle.none
            return cellHeader
        }
        else if indexPath.row == 1 {
            cellTextNews.configureTextNews(textNews: currentTextNews)
            cellTextNews.selectionStyle = UITableViewCell.SelectionStyle.none
        return cellTextNews
        }
        else if indexPath.row == 2 {
            cellImageNews.configureImageNews(imageNews: UIImage(named:"Avatar1.jpg") ?? UIImage())
            cellImageNews.selectionStyle = UITableViewCell.SelectionStyle.none
            return cellImageNews
        }
        else if indexPath.row == 3{
            cellFooter.configureFooter(numOfViews: "280")
            cellFooter.selectionStyle = UITableViewCell.SelectionStyle.none
            return cellFooter
        }
        return UITableViewCell()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
