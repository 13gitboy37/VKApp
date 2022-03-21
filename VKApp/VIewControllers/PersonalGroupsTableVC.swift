//
//  PersonalGroupsTableVC.swift
//  VKApp
//
//  Created by Никита Мошенцев on 22.12.2021.
//

import UIKit
import RealmSwift

final class PersonalGroupsTableVC: UITableViewController {
    
    private  var groups: Results<RealmGroup>? = try? RealmService.load(typeOf: RealmGroup.self)
    private var groupsToken: NotificationToken?
     

   @IBAction func addGroup(segue: UIStoryboardSegue) {
        guard
            segue.identifier == "addGroup",
            let allGroupsController = segue.source as? GlobalGroupsTableVC,
            let groupIndexPath = allGroupsController.tableView.indexPathForSelectedRow//,
 //           !self.groups.contains(allGroupsController.groups[groupIndexPath.row])
        else { return }
       do {
           let currentGroup = allGroupsController.groups![groupIndexPath.row]
           let realm = try Realm()
           realm.beginWrite()
               let currentAddGroup = RealmGroup()
               currentAddGroup.id = currentGroup.id
               currentAddGroup.name = currentGroup.name
               currentAddGroup.groupsPhoto = currentGroup.groupsPhoto
               realm.add(currentAddGroup)
           try realm.commitWrite()
       } catch {
           print(error)
       }
    }
    
    private let networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(
            nibName: "GroupsCell",
            bundle: nil),
                           forCellReuseIdentifier: "groupsCell")
        
        networkService.getGroups() { [weak self] result in
            switch result {
            case .success(let groups):
                let realmGroup = groups.map { RealmGroup(groups: $0)}
                    do {
                    try RealmService.save(items: realmGroup)
                    self?.groups = try RealmService.load(typeOf: RealmGroup.self)
                    self?.tableView.reloadData()
                    } catch {
                        print(error)
                    }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        groupsToken = groups?.observe { [weak self] groupsChanges in
            guard let self = self else { return }
            switch groupsChanges {
            case .initial(_):
                self.tableView.reloadData()
            case let .update(
                _,
                deletions: deletions,
                insertions: insertions,
                modifications: modifications):
                self.tableView.beginUpdates()
                
                let delRowsIndex = deletions.map { IndexPath(
                    row: $0,
                    section: 0) }
                let insertRowsIndex = insertions.map { IndexPath(
                    row: $0,
                    section: 0)}
                let modificationIndex = modifications.map { IndexPath(
                    row: $0,
                    section: 0)}
                
                self.tableView.deleteRows(at: delRowsIndex, with: .automatic)
                self.tableView.insertRows(at: insertRowsIndex, with: .automatic)
                self.tableView.reloadRows(at: modificationIndex, with: .automatic)
                
                self.tableView.endUpdates()
            case .error(let error):
                print(error)
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        groupsToken?.invalidate()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     guard
            let currentGroup = groups?[indexPath.item],
            let cell = tableView.dequeueReusableCell(withIdentifier: "groupsCell", for: indexPath) as? GroupsCell
     else { return UITableViewCell() }
     
        cell.configure(model: currentGroup)
        return cell
        
    }

    // Override to support editing the table view.
    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deleteGroup = self.groups![indexPath.row]
        do {
            let realm = try Realm()
            let currentDeleteGroup = try realm.objects(RealmGroup.self).filter("id == %@", deleteGroup.id)
            try? RealmService.delete(object: currentDeleteGroup)
        } catch {
            print(error)
                }
            }
        }
}
