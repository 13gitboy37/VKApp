//
//  PersonalGroupsTableVC.swift
//  VKApp
//
//  Created by Никита Мошенцев on 22.12.2021.
//

import UIKit
import RealmSwift

final class PersonalGroupsTableVC: UITableViewController {
    
    private  var groups: Results<RealmGroup>? = try? RealmService.load(typeOf: RealmGroup.self){
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

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
           DispatchQueue.main.async {
               self.tableView.reloadData()
           }
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
                DispatchQueue.main.async {
                    do {
                    try RealmService.save(items: realmGroup)
                    self?.groups = try RealmService.load(typeOf: RealmGroup.self)
                    self?.tableView.reloadData()
                    } catch {
                        print(error)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
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
            DispatchQueue.main.async {
                try? RealmService.delete(object: currentDeleteGroup)
                tableView.deleteRows(
                    at: [indexPath],
                    with: .fade)
            }
        } catch {
            print(error)
                }
            }
        }
}
