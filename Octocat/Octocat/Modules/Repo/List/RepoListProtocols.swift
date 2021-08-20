//
//  RepoListProtocols.swift
//  Octocat
//
//  Created by Thijs Verboon on 19/08/2021.
//

// MARK: Wireframe -
protocol RepoListWireframeProtocol: AnyObject {
}

// MARK: Presenter -
protocol RepoListPresenterProtocol: AnyObject {
	var interactor: RepoListInteractorProtocol? { get set }
	var view: RepoListViewProtocol? { get set }
	var wireframe: RepoListWireframeProtocol? { get set }

    func viewWillAppear()
    func didFetchData(repos: [Repo])
    func didFailToFetchData()
}

// MARK: Interactor -
protocol RepoListInteractorProtocol: AnyObject {
	var presenter: RepoListPresenterProtocol? { get set }
	var serviceClient: GithubServiceClientProtocol? { get set }

    func fetchData(logins: [String])
}

// MARK: View -
protocol RepoListViewProtocol: AnyObject {
	var presenter: RepoListPresenterProtocol? { get set }

    func configure(repos: [RepoListViewModel])
    func toggleActivityIndicator(on: Bool)
}
