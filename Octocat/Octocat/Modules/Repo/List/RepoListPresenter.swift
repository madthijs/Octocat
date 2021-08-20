//
//  RepoListPresenter.swift
//  Octocat
//
//  Created by Thijs Verboon on 19/08/2021.
//

class RepoListPresenter: RepoListPresenterProtocol, RepoListViewModelProtocol {
    var interactor: RepoListInteractorProtocol?
    var view: RepoListViewProtocol?
    var wireframe: RepoListWireframeProtocol?

    private var isLoading: Bool = false {
        didSet {
            view?.toggleActivityIndicator(on: isLoading)
        }
    }

    func viewWillAppear() {
        isLoading = true
        interactor?.fetchData(logins: ["JakeWharton", "madthijs"])
    }

    func didFetchData(repos: [Repo]) {
        if repos.isEmpty {
            didFailToFetchData()
            return
        }

        isLoading = false
        view?.configure(repos: repos.map({ mapToViewModel(repo: $0) }))
    }

    func didFailToFetchData() {
        isLoading = false

        //show error message, simple alert for now with retry

    }

}
