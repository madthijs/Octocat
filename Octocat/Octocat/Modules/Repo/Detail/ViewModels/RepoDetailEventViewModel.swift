//
//  RepoDetailEventViewModel.swift
//  Octocat
//
//  Created by Thijs Verboon on 21/08/2021.
//

import Foundation

struct RepoDetailEventViewModel {
    var name: String
    var authorName: String
    var created: Date?
}

protocol RepoDetailEventViewModelProtocol: AnyObject {
    func mapToViewModel(event: Event) -> RepoDetailEventViewModel
}

extension RepoDetailEventViewModelProtocol {
    func mapToViewModel(event: Event) -> RepoDetailEventViewModel {
        return RepoDetailEventViewModel(
            name: "\(event.type)",
            authorName: event.actor.login,
            created: event.created
        )
    }
}
