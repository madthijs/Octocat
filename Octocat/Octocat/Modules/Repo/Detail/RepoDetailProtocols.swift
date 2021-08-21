//
//  RepoListProtocols.swift
//  Octocat
//
//  Created by Thijs Verboon on 19/08/2021.
//
import UIKit

// MARK: Wireframe -
protocol RepoDetailWireframeProtocol: AnyObject {

}

// MARK: Presenter -
protocol RepoDetailPresenterProtocol: AnyObject {
	var interactor: RepoDetailInteractorProtocol? { get set }
	var view: RepoDetailViewProtocol? { get set }
	var wireframe: RepoDetailWireframeProtocol? { get set }

    var login: String { get set }
    var repoName: String { get set }

    func viewWillAppear()
    func didFetchData(repo: Repo)
    func didFetchData(events: [Event])
    func didFailToFetchData()

    func openUrl(url: URL)
}

// MARK: Interactor -
protocol RepoDetailInteractorProtocol: AnyObject {
	var presenter: RepoDetailPresenterProtocol? { get set }
	var serviceClient: GithubServiceClientProtocol? { get set }

    func fetchData(login: String, repoName: String)
}

// MARK: View -
protocol RepoDetailViewProtocol: AnyObject {
	var presenter: RepoDetailPresenterProtocol? { get set }

    func configure(repo: RepoDetailViewModel)
    func configure(events: [RepoDetailEventViewModel])
    func toggleActivityIndicator(on: Bool)
}
