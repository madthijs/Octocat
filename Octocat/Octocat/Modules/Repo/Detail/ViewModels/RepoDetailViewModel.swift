//
//  RepoDetailViewModel.swift
//  Octocat
//
//  Created by Thijs Verboon on 21/08/2021.
//

import Foundation

struct RepoDetailViewModel {
    var name: String
    var description: String?
    var ownerAvatarURL: URL?
    var ownerLogin: String
    var watcherCount: Int
    var forkCount: Int
    var url: URL?

}

protocol RepoDetailViewModelProtocol: AnyObject {
    func mapToViewModel(repo: Repo) -> RepoDetailViewModel
}

extension RepoDetailViewModelProtocol {
    func mapToViewModel(repo: Repo) -> RepoDetailViewModel {
        return RepoDetailViewModel(
            name: repo.name,
            description: repo.description,
            ownerAvatarURL: repo.owner.avatarUrl,
            ownerLogin: repo.owner.login,
            watcherCount: repo.watchers,
            forkCount: repo.forks,
            url: repo.url
        )
    }
}
