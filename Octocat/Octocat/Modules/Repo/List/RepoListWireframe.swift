//
//  RepoListWireframe.swift
//  Octocat
//
//  Created by Thijs Verboon on 19/08/2021.
//
import UIKit

class RepoListWireframe: RepoListWireframeProtocol {

	static func create() -> UIViewController {
		let navController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MainNavigation") as! UINavigationController

		guard let viewController = navController.topViewController as? RepoListViewController else { fatalError("Invalid View Controller") }

		let wireframe: RepoListWireframeProtocol = RepoListWireframe()
        let presenter: RepoListPresenterProtocol = RepoListPresenter()
        let interactor: RepoListInteractorProtocol = RepoListInteractor()

        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.serviceClient = GithubServiceClient()

		return navController
	}
}
