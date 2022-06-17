//
//  GlobalGroupsTableVC.swift
//  VKApp
//
//  Created by Никита Мошенцев on 22.12.2021.
//

import UIKit
import RealmSwift

final class GlobalGroupsTableVC: UITableViewController {
    @IBOutlet var searchBar: UISearchBar!
   
    var groups: Results<RealmSearchGroup>? = try? RealmService.load(typeOf: RealmSearchGroup.self) {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private let viewModelFactory = GroupViewModelFactory()
    private var viewModels: [GroupViewModel] = []
       
    private var timer = Timer()
    var searchGroups:[String]!
    private let networkService = NetworkService()
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(
            nibName: "GroupsCell",
            bundle: nil),
                           forCellReuseIdentifier: "groupsCell")
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//      groups?.count ?? 0
        viewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     guard
         let cell = tableView.dequeueReusableCell(withIdentifier: "groupsCell", for: indexPath) as? GroupsCell
     else { return UITableViewCell() }
     
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? GroupsCell else { return }
        
        cell.configure(model: viewModels[indexPath.row])
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
      let networkServiceProxy = NetworkServiceProxy(networkService: networkService)
            groups?.forEach({ deleteGroup in
                do {
                    let realm = try Realm()
                    let currentDeleteGroup = realm.objects(RealmSearchGroup.self).filter("id == %@", deleteGroup.id)
                    try RealmService.delete(object: currentDeleteGroup)
                } catch {
                    print(error)
                }
            })
            timer.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { _ in
                networkServiceProxy.getSearchGroups(searchText: searchText.lowercased())
                { [weak self] result in
                    switch result {
                    case .success(let groups):
                        let realmGroup = groups.map { RealmSearchGroup(seatchGroupName: searchText, groups: $0)}
                        self?.viewModels = self?.viewModelFactory.constructViewModels(from: realmGroup) ?? []
                        DispatchQueue.main.async {
                            do {
                            try RealmService.save(items: realmGroup)
                            self?.tableView.reloadData()
                            } catch {
                                print(error)
                            }
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            })
        }
 }
