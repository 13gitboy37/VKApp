//
//  GroupsViewModel.swift
//  VKApp
//
//  Created by Никита Мошенцев on 29.05.2022.
//

import Foundation

struct GroupViewModel {
    let groupText: String
    let iconGroupImage: String
}

final class GroupViewModelFactory {
    func constructViewModels(from groups: [RealmSearchGroup]) -> [GroupViewModel] {
        return groups.compactMap(self.viewModel)
    }
    
    private func viewModel(from groups: RealmSearchGroup) -> GroupViewModel {
        let groupText = groups.name
        let iconGroupImage = groups.groupsPhoto
        return GroupViewModel(groupText: groupText, iconGroupImage: iconGroupImage)
    }
}
