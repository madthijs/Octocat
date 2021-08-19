//
//  RepoListProtocols.swift
//  Octocat
//
//  Created by Thijs Verboon on 19/08/2021.
//

// MARK: Wireframe -
protocol RepoListWireframeProtocol: class {
}

// MARK: Presenter -
protocol RepoListPresenterProtocol: class {
	var interactor: RepoListInteractorProtocol? { get set }
	var view: RepoListViewProtocol? { get set }
	var wireframe: RepoListWireframeProtocol? { get set }
}

// MARK: Interactor -
protocol RepoListInteractorProtocol: class {
	var presenter: RepoListPresenterProtocol? { get set }
	var serviceClient: GithubServiceClientProtocol? { get set }
}

// MARK: View -
protocol RepoListViewProtocol: class {
	var presenter: RepoListPresenterProtocol? { get set }
}
