//
//  RepoListProtocols.swift
//  Octocat
//
//  Created by Thijs Verboon on 19/08/2021.
//
import UIKit

// MARK: Wireframe -
protocol RepoListWireframeProtocol: AnyObject {
    var navController: UINavigationController? { get set }
    func showAppInfo()
    func showRepoDetail(login: String, repoName: String)
}

// MARK: Presenter -
protocol RepoListPresenterProtocol: AnyObject {
	var interactor: RepoListInteractorProtocol? { get set }
	var view: RepoListViewProtocol? { get set }
	var wireframe: RepoListWireframeProtocol? { get set }
    var logins: [String] { get set }

    func viewWillAppear()
    func didFetchData(repos: [Repo])
    func didFailToFetchData()
    func showAppInfo()
    func showRepoDetail(login: String, repoName: String)
    
    func showAddLogin()
    func didFailToAddLogin(login: String)
    func didAddLogin(login: String, repos: [Repo])
}

// MARK: Interactor -
protocol RepoListInteractorProtocol: AnyObject {
	var presenter: RepoListPresenterProtocol? { get set }
	var serviceClient: GithubServiceClientProtocol? { get set }

    func fetchData(logins: [String])
    func validateLogin(login: String)
}

// MARK: View -
protocol RepoListViewProtocol: AnyObject {
	var presenter: RepoListPresenterProtocol? { get set }

    func configure(repos: [RepoListViewModel])
    func configureAdditional(repos: [RepoListViewModel])
    func toggleActivityIndicator(on: Bool)
}
