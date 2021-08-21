//
//  RepoListViewModel.swift
//  Octocat
//
//  Created by Thijs Verboon on 20/08/2021.
//

import Foundation

struct RepoListViewModel {
    var name: String
    var ownerAvatarURL: URL?
    var ownerLogin: String
    var watcherCount: Int
    var forkCount: Int

}

protocol RepoListViewModelProtocol: AnyObject {
    func mapToViewModel(repo: Repo) -> RepoListViewModel
}

extension RepoListViewModelProtocol {
    func mapToViewModel(repo: Repo) -> RepoListViewModel {
        return RepoListViewModel(
            name: repo.name,
            ownerAvatarURL: repo.owner.avatarUrl,
            ownerLogin: repo.owner.login,
            watcherCount: repo.watchers,
            forkCount: repo.forks
        )
    }
}
