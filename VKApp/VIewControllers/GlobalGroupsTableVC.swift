//
//  GlobalGroupsTableVC.swift
//  VKApp
//
//  Created by Никита Мошенцев on 22.12.2021.
//

import UIKit

final class GlobalGroupsTableVC: UITableViewController {
    @IBOutlet var searchBar: UISearchBar!
    var groups = [
        "News",
        "New Rap",
        "Fast Food Music",
        "Trasher Magazine",
        "CS: GO"
    ]
    
    var searchGroups:[String]!
   
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        searchGroups = groups
        super.viewDidLoad()
        tableView.register(UINib(
            nibName: "GroupsCell",
            bundle: nil),
                           forCellReuseIdentifier: "groupsCell")
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchGroups.count
    }
    
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     guard
         let cell = tableView.dequeueReusableCell(withIdentifier: "groupsCell", for: indexPath) as? GroupsCell
     else { return UITableViewCell() }
     
    let currentGroup = searchGroups[indexPath.row]
     
     cell.configure(
         emblem: UIImage(systemName: "\(indexPath.row).circle") ?? UIImage(),name: currentGroup)
        return cell
    }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(
            at: indexPath,
            animated: true) }
            performSegue(
            withIdentifier: "addGroup",
            sender: nil)
    }

}

//MARK: Realese UISearchBar
extension GlobalGroupsTableVC: UISearchBarDelegate {
   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
        if searchText == "" {
            searchGroups = groups
        } else {
            searchGroups = []
           for searchTextIndex in groups {
               if searchTextIndex.lowercased().contains(searchText.lowercased()){
                    searchGroups.append(searchTextIndex)
                    }
                }
            
            }
        tableView.reloadData()
    }
}
