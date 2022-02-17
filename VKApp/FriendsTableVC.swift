//
//  FriendsTableVC.swift
//  VKApp
//
//  Created by Никита Мошенцев on 22.12.2021.
//

import UIKit
import Alamofire

final class FriendsTableVC: UITableViewController {

    var friendsDictionary = [String: [String]]()
    var friendsSectionTitles = [String]()
    var friends = [
    "Ivanov Ivan",
    "Iskanderov Konstantin",
    "Alexandrov Alex",
    "Viktorov Viktor",
    "Zuckerberg Mark",
    "Jobs Steven",
    "Zaharov Inokentiy"]
    
  func SortFriend() -> [String] {
        var sortedFriends = [String]()
        sortedFriends = self.friends.sorted{$0 < $1}
        return sortedFriends
    }
 
    private let networkService = NetworkService()
    
    // MARK: - Table view data source
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(
            nibName: "FriendsCell",
            bundle: nil),
                           forCellReuseIdentifier: "friendCell")
        for friend in SortFriend() {
            let friendKey = String(friend.prefix(1))
            if var friendValues = friendsDictionary[friendKey] {
                friendValues.append(friend)
                friendsDictionary[friendKey] = friendValues
            } else {
                friendsDictionary[friendKey] = [friend]
            }
        }
        
        friendsSectionTitles = [String](friendsDictionary.keys)
        self.friendsSectionTitles = self.friendsSectionTitles.sorted(by: {$0 < $1})
        networkService.getFriends()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return friendsSectionTitles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let friendKey = friendsSectionTitles[section]
        if let friendValues = friendsDictionary[friendKey] {
            return friendValues.count
        }
        return 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
           let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as? FriendsCell
        else { return UITableViewCell() }
       let friendKey = friendsSectionTitles[indexPath.section]
        if let friendValues = friendsDictionary[friendKey] {
            cell.configure(
                emblem: UIImage(named: "ava.jpg") ?? UIImage(), name: friendValues[indexPath.row])
        }
     //   cell.addGestureRecognizer(UITapGestureRecognizer)
      //  cell.animateImage()
        
        return cell
    }
    
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(
            at: indexPath,
            animated: true) }
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
             self.performSegue(withIdentifier: "showPhotosFriend", sender: nil)
         }
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
