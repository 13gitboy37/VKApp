//
//  FriendsTableVC.swift
//  VKApp
//
//  Created by Никита Мошенцев on 22.12.2021.
//

import UIKit
import Alamofire

final class FriendsTableVC: UITableViewController {

    var friendsDictionary = [String: [UserItems]]()
    var friendsSectionTitles = [String]()
    var friendsSortedDictionary = [String: [UserItems]]()
    private var users = [UserItems]() {
        didSet {
            
                
                for user in self.users where user.firstName != "DELETED" {
                    self.friendsDictionary.removeAll()
                    self.users.sort()

                for friend in self.users.indices  {
                    let friendKey = String(self.users[friend].lastName.prefix(1))
                    if var friendValues = self.friendsDictionary[friendKey] {
                        friendValues.append(self.users[friend])
                        self.friendsDictionary[friendKey] = friendValues
                    } else {
                        self.friendsDictionary[friendKey] = [self.users[friend]]
                    }
                }
                
                self.friendsSectionTitles = [String](self.friendsDictionary.keys).sorted{ $0 < $1 }
                }
            
            DispatchQueue.main.async {
                self.friendsSortedDictionary = self.friendsDictionary
                self.tableView.reloadData()
            }
        }
    }
 
    private let networkService = NetworkService()
    
    // MARK: - Table view data source
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkService.getFriends() { [weak self] result in
        switch result {
            case .success(let users):
                self?.users = users
       //         self?.friendPhoto = users
            case .failure(let error):
                print(error)
        }
    }
        
        tableView.register(UINib(
            nibName: "FriendsCell",
            bundle: nil),
                           forCellReuseIdentifier: "friendCell")
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        friendsSectionTitles = [String](friendsDictionary.keys)
        self.friendsSectionTitles = self.friendsSectionTitles.sorted(by: {$0 < $1})
       return friendsSectionTitles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friendsSortedDictionary[friendsSectionTitles[section]]!.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
           let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as? FriendsCell
        else { return UITableViewCell() }
        
        let friendKey = friendsSectionTitles[indexPath.section]
        if let friendValues = friendsDictionary[friendKey] {
            let friendsInCell = friendValues[indexPath.row]
            cell.configure(emblem:friendsInCell.userPhoto,
                           name: friendsInCell.fullName)
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showPhotosFriend", let indexPath = tableView.indexPathForSelectedRow
        else { return }
        
        guard let destination = segue.destination as? PhotoFriendsCollectionVC else { return }
        
        let friendKey = friendsSectionTitles[indexPath.section]
        if let friendValues = friendsSortedDictionary[friendKey] {
            destination.photoFriends = friendValues[indexPath.row]
        }
    }
    
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(
            at: indexPath,
            animated: true) }
//         DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
             self.performSegue(withIdentifier: "showPhotosFriend", sender: nil)
  //       }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return friendsSectionTitles[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
       return friendsSectionTitles
    }
    
    
  override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
      header.tintColor = UIColor.gray.withAlphaComponent(0.05)
    }
}

extension FriendsTableVC: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
