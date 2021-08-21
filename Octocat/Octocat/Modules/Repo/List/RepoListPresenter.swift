//
//  RepoListPresenter.swift
//  Octocat
//
//  Created by Thijs Verboon on 19/08/2021.
//

import Foundation
import UIKit

class RepoListPresenter: RepoListPresenterProtocol, RepoListViewModelProtocol {
    var interactor: RepoListInteractorProtocol?
    var view: RepoListViewProtocol?
    var wireframe: RepoListWireframeProtocol?

    var logins: [String] {
        get {
            let values = UserDefaults().stringArray(forKey: "logins") ?? ["JakeWharton", "infinum", "madthijs"]
            return values.sorted{ (lhs: String, rhs: String) -> Bool in
                return lhs.compare(rhs, options: .caseInsensitive) == .orderedAscending
            }
        }
        set {
            UserDefaults().set(newValue, forKey: "logins")
        }
    }

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
        interactor?.fetchData(logins: logins)
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
        let alert = UIAlertController(title: "Oops", message: "Unable to connect to the mothership! Please check your internet connection and retry.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in
            self.loadData()
        }))

        (view as? UIViewController)?.present(alert, animated: true)
    }

    func showAppInfo() {
        wireframe?.showAppInfo()
    }

    func showRepoDetail(login: String, repoName: String) {
        wireframe?.showRepoDetail(login: login, repoName: repoName)
    }

    func showAddLogin() {
        //use simple alert with input for now
        let alert = UIAlertController(title: "Add Repos", message: "Enter a valid Github username to add repositories.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { action in
            if let name = alert.textFields?.first?.text?.trimmingCharacters(in: .whitespacesAndNewlines), !name.isEmpty {
                self.addLogin(login: name)
            } else {
                self.didFailToAddLogin(login: "")
            }
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Github username..."
        })

        (view as? UIViewController)?.present(alert, animated: true)
    }

    func didFailToAddLogin(login: String) {
        //show error message, simple alert for now with retry
        let alert = UIAlertController(title: "No luck", message: "The user '\(login)' could not be found, or did not have any public repositories.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))

        (view as? UIViewController)?.present(alert, animated: true)
    }

    func didAddLogin(login: String, repos: [Repo]) {
        logins.append(login)
        view?.configureAdditional(repos: repos.map({ mapToViewModel(repo: $0) }))
    }

    private func addLogin(login: String) {
        interactor?.validateLogin(login: login)
    }

}
