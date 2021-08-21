//
//  RepoDetailWireframe.swift
//  Octocat
//
//  Created by Thijs Verboon on 21/08/2021.
//
import UIKit

class RepoDetailWireframe: RepoDetailWireframeProtocol {
    static func create(withLogin login: String, repoName: String) -> UIViewController? {
		guard let viewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "\(RepoDetailViewController.self)") as? RepoDetailViewProtocol else {
            fatalError("Invalid View Controller")
        }

		let wireframe: RepoDetailWireframeProtocol = RepoDetailWireframe()
        let presenter: RepoDetailPresenterProtocol = RepoDetailPresenter()
        let interactor: RepoDetailInteractorProtocol = RepoDetailInteractor()

        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        presenter.login = login
        presenter.repoName = repoName
        interactor.presenter = presenter
        interactor.serviceClient = GithubServiceClient()

		return viewController as? UIViewController
	}
}
