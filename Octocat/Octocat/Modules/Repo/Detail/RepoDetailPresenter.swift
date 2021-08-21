//
//  RepoDetailPresenter.swift
//  Octocat
//
//  Created by Thijs Verboon on 19/08/2021.
//

import Foundation
import UIKit

class RepoDetailPresenter: RepoDetailPresenterProtocol, RepoDetailViewModelProtocol, RepoDetailEventViewModelProtocol {

    var interactor: RepoDetailInteractorProtocol?
    var view: RepoDetailViewProtocol?
    var wireframe: RepoDetailWireframeProtocol?

    var login: String = ""
    var repoName: String = ""

    private var isLoading: Bool = false {
        didSet {
            view?.toggleActivityIndicator(on: isLoading)
        }
    }

    func viewWillAppear() {
        loadData()
    }

    private func loadData() {
        isLoading = true
        interactor?.fetchData(login: login, repoName: repoName)
    }

    func didFetchData(repo: Repo) {
        isLoading = false
        view?.configure(repo: mapToViewModel(repo: repo))
    }

    func didFetchData(events: [Event]) {
        isLoading = false
        view?.configure(events: events.map({ mapToViewModel(event: $0) }))
    }

    func didFailToFetchData() {
        isLoading = false

        //show error message, simple alert for now with retry
        let alert = UIAlertController(title: "Oops", message: "Unable to connect to the mothership! Please check your internet connection and retry.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in
            self.loadData()
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            (self.view as? UIViewController)?.dismiss(animated: true)
        }))


        (view as? UIViewController)?.present(alert, animated: true)

    }

    func openUrl(url: URL) {
        UIApplication.shared.open(url)
    }

}
