//
//  GithubServiceClientProtocol.swift
//  Octocat
//
//  Created by Thijs Verboon on 18/08/2021.
//

import PromiseKit

protocol GithubServiceClientProtocol: AnyObject {
    func fetchRepo(withLogin login: String, name: String) -> Promise<Repo>
    func fetchRepos(withLogin login: String) -> Promise<[Repo]>
    func fetchUser(withLogin login: String) -> Promise<User>
    func fetchEvents(withLogin login: String, repoName name: String) -> Promise<[Event]>

}
