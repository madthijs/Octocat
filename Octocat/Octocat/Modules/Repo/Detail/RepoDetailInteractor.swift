//
//  RepoDetailInteractor.swift
//  Octocat
//
//  Created by Thijs Verboon on 19/08/2021.
//

import PromiseKit

class RepoDetailInteractor: RepoDetailInteractorProtocol {
    var presenter: RepoDetailPresenterProtocol?
    var serviceClient: GithubServiceClientProtocol?

    func fetchData(login: String, repoName: String) {
        //get the repo details
        serviceClient?.fetchRepo(withLogin: login, name: repoName)
            .done { result in
                self.presenter?.didFetchData(repo: result)
            }
            .catch { error in
                self.presenter?.didFailToFetchData()
                print("Error: ", error.localizedDescription)
            }

        //get the events
        serviceClient?.fetchEvents(withLogin: login, repoName: repoName)
            .done { results in
                self.presenter?.didFetchData(events: results)
            }
            .catch { error in
                self.presenter?.didFetchData(events: [])
                print("Error: ", error.localizedDescription)
            }
    }
}
