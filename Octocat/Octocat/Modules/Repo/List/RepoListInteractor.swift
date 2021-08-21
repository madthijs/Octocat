//
//  RepoListInteractor.swift
//  Octocat
//
//  Created by Thijs Verboon on 19/08/2021.
//

import PromiseKit

class RepoListInteractor: RepoListInteractorProtocol {
    var presenter: RepoListPresenterProtocol?
    var serviceClient: GithubServiceClientProtocol?

    func fetchData(logins: [String]) {
        var promises: [Promise<[Repo]>] = []

        if let serviceClient = serviceClient {
            promises = logins.map {
                serviceClient.fetchRepos(withLogin: $0)
            }
        }

        firstly {
            when(resolved: promises)
        }.done { results in
            var repos: [Repo] = []

            for result: Result<[Repo]> in results {
                switch result {
                    case .fulfilled(let data):
                        repos.append(contentsOf: data)
                    case .rejected(let error):
                        print(error)
                }
            }

            self.presenter?.didFetchData(repos: repos)

        }.catch { error in
            print("Error: ", error.localizedDescription)
            self.presenter?.didFailToFetchData()
        }
    }

    func fetchData(login: String) {
        serviceClient?.fetchRepos(withLogin: login)
            .done { results in
                if results.isEmpty {
                    self.presenter?.didFailToAddLogin(login: login)
                    return
                }

                self.presenter?.didAddLogin(login: login, repos: results)
            }
            .catch { error in
                print("Error: ", error.localizedDescription)
                self.presenter?.didFailToAddLogin(login: login)
            }
    }
}
