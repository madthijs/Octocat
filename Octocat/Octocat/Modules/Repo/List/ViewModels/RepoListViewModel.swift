//
//  RepoListViewModel.swift
//  Octocat
//
//  Created by Thijs Verboon on 20/08/2021.
//

import Foundation

struct RepoListViewModel: Hashable {
    var name: String
    var description: String
    var ownerAvatarURL: URL?
    var ownerLogin: String

}

protocol RepoListViewModelProtocol: AnyObject {
    func mapToViewModel(repo: Repo) -> RepoListViewModel
}

extension RepoListViewModelProtocol {
    func mapToViewModel(repo: Repo) -> RepoListViewModel {
        return RepoListViewModel(
            name: repo.name,
            description: repo.description,
            ownerAvatarURL: repo.owner.avatarUrl,
            ownerLogin: repo.owner.login
        )
    }
}
