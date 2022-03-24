//
//  FriendsTableVC.swift
//  VKApp
//
//  Created by Никита Мошенцев on 22.12.2021.
//

import UIKit
import Alamofire
import RealmSwift
import FirebaseDatabase

final class FriendsTableVC: UITableViewController {

    
    @IBAction func addFriend(_ sender: Any) {
        let alertController = UIAlertController(
            title: "Enter friend full name: ",
            message: nil,
            preferredStyle: .alert)
        alertController.addTextField { _ in }
        
        let confirm = UIAlertAction(title: "Add", style: .default) { action in
            guard let fullName = alertController.textFields?.first?.text else { return }
            let fbFriend = FirebaseFriend(fullName: fullName)
            self.reference.child(fullName.lowercased()).setValue((fbFriend.toAnyObject()))
        }
        
        let cancel = UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: nil)
        alertController.addAction(confirm)
        alertController.addAction(cancel)
        
        present(
        alertController,
        animated: true,
        completion: nil)
    }
    
    private var users = [FirebaseFriend]()
    private let reference = Database.database().reference()
    

    // MARK: - Table view data source
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.register(UINib(
            nibName: "FriendsCell",
            bundle: nil),
                           forCellReuseIdentifier: "friendCell")
        reference.observe(.value) { [weak self] snapshot in
            guard let self = self else { return }
            var friend = [FirebaseFriend]()
            snapshot.children.forEach {
                guard let childSnap = $0 as? DataSnapshot,
                      let fullName = FirebaseFriend(snapshot: childSnap)
                else { return }
                friend.append(fullName)
            }
            self.users = friend
            self.tableView.reloadData()
        }

    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let friend = users[indexPath.row]
            friend.reference?.removeValue()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        friendsToken?.invalidate()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return users.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
           let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as? FriendsCell
        else { return UITableViewCell() }
        
        cell.configure(users[indexPath.row])

        return cell
    }
    
    
}

