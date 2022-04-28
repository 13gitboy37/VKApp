//
//  FriendsTableVC.swift
//  VKApp
//
//  Created by Никита Мошенцев on 22.12.2021.
//

import UIKit
import Alamofire
import RealmSwift
import SystemConfiguration

final class FriendsTableVC: UITableViewController {

   private var friendsDictionary = [String: [RealmUser?]]()
   private var friendsSectionTitles = [String]()
   private var friendsSortedDictionary = [String: [RealmUser?]]()
   private var sortedUsers = [RealmUser?]()
    
   private func SortFriend() {
        for user in self.users! where user.lastName != "" {
            self.friendsDictionary.removeAll()
            self.sortedUsers = self.users!.sorted()

            for friend in self.sortedUsers.indices {
            let friendKey = String(self.sortedUsers[friend]!.lastName.prefix(1))
            if var friendValues = self.friendsDictionary[friendKey] {
                if self.sortedUsers[friend]!.firstName != "DELETED" {
                friendValues.append(self.sortedUsers[friend]!)
                self.friendsDictionary[friendKey] = friendValues
                }
            } else {
                self.friendsDictionary[friendKey] = [self.sortedUsers[friend]]
            }
        }

        self.friendsSectionTitles = [String](self.friendsDictionary.keys).sorted{ $0 < $1 }
        }
    
        self.friendsSortedDictionary = self.friendsDictionary
    }
    
    private var users: Results<RealmUser>? = try? RealmService.load(typeOf: RealmUser.self)
    
    private var friendsToken: NotificationToken?
 
    private let networkService = NetworkService()
    
    // MARK: - Table view data source
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(
            nibName: "FriendsCell",
            bundle: nil),
                           forCellReuseIdentifier: "friendCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        networkService.getUrl().get ({ print($0)
        })
        .then(on: .global(), networkService.getData(_:))
        .then(networkService.getParsedData(_:))
        .done(on: .main) { friend in
            let realmUser = friend.map { RealmUser(users: $0) }
            do {
                try RealmService.save(items: realmUser)
            } catch {
                print(error)
            }
        } .catch { error in
            print(error)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        friendsToken = users?.observe { [weak self] friendsChanges in
            guard let self = self else { return }
            switch friendsChanges {
            case .initial(_),
                    .update(
                        _,
                        deletions: _,
                        insertions: _,
                        modifications: _):
                self.SortFriend()
                self.tableView.reloadData()
            case .error(let error):
                print(error)
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        friendsToken?.invalidate()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
       friendsSectionTitles = [String](friendsDictionary.keys)
        self.friendsSectionTitles = self.friendsSectionTitles.sorted(by: {$0 < $1})
       return friendsSectionTitles.count
    
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friendsSortedDictionary[friendsSectionTitles[section]]?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
           let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as? FriendsCell
        else { return UITableViewCell() }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard
           let cell = cell as? FriendsCell
        else { return }
        let friendKey = friendsSectionTitles[indexPath.section]
                if let friendValues = friendsDictionary[friendKey] {
                    let friendsInCell = friendValues[indexPath.row]
                    cell.configure(emblem:friendsInCell?.userPhoto ?? "",
                                   name: friendsInCell?.fullName ?? "")
                }
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

             self.performSegue(withIdentifier: "showPhotosFriend", sender: nil)

    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return friendsSectionTitles[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
       return friendsSectionTitles
    }
    
    
  override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
      header.tintColor = UIColor.systemGray6
    }
}

