//
//  PersonalGroupsTableVC.swift
//  VKApp
//
//  Created by Никита Мошенцев on 22.12.2021.
//

import UIKit
import RealmSwift
import Alamofire

final class PersonalGroupsTableVC: UITableViewController {
    
    private var groups: Results<RealmGroup>? = try? RealmService.load(typeOf: RealmGroup.self)
    private var groupsToken: NotificationToken?

   @IBAction func addGroup(segue: UIStoryboardSegue) {
        guard
            segue.identifier == "addGroup",
            let allGroupsController = segue.source as? GlobalGroupsTableVC,
            let groupIndexPath = allGroupsController.tableView.indexPathForSelectedRow
        else { return }
       do {
           guard let currentGroup = allGroupsController.groups?[groupIndexPath.row]
            else { return }
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
       
       private let operationQueue: OperationQueue = {
           let operationQueue = OperationQueue()
           operationQueue.name = "operationQueue"
           operationQueue.qualityOfService = .utility
           return operationQueue
       }()

    private let networkService = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(
            nibName: "GroupsCell",
            bundle: nil),
                           forCellReuseIdentifier: "groupsCell")
        
        let request = AF.request("https://api.vk.com//method/groups.get?access_token=\(UserSession.instance.token)&v=5.131&extended=1&fields=photo_100")
        let getData = GetDataOperation(request: request)
        
        let parseData = ParseDataOperation()
        parseData.addDependency(getData)
        
        let realmSaveGroups = RealmSaveGroups(realmGroups: parseData.outputData)
        realmSaveGroups.addDependency(parseData)
        
        operationQueue.addOperation(getData)
        operationQueue.addOperation(parseData)
        OperationQueue.main.addOperation(realmSaveGroups)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        groupsToken = groups?.observe { [weak self] groupsChanges in
            guard let self = self else { return }
            switch groupsChanges {
            case .initial(_),
                .update(_,
                         deletions: _,
                        insertions: _,
                        modifications: _):
                self.tableView.reloadData()
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "groupsCell", for: indexPath) as? GroupsCell
     else { return UITableViewCell() }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard
               let currentGroup = groups?[indexPath.item],
               let cell = cell as? GroupsCell else { return }
        
        cell.configure(model: currentGroup)
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let deleteGroup = self.groups?[indexPath.row] else { return }
        do {
            let realm = try Realm()
            let currentDeleteGroup = realm.objects(RealmGroup.self).filter("id == %@", deleteGroup.id)
            try? RealmService.delete(object: currentDeleteGroup)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        } catch {
            print(error)
                }
            }
        }
}
