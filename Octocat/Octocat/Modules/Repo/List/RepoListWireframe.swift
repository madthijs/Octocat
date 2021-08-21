//
//  RepoListWireframe.swift
//  Octocat
//
//  Created by Thijs Verboon on 19/08/2021.
//
import UIKit

class RepoListWireframe: RepoListWireframeProtocol {
    weak var navController: UINavigationController?

	static func create() -> UIViewController {
        guard let navController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MainNavigation") as? UINavigationController else {
            fatalError("No NavController Found")
        }

		guard let viewController = navController.topViewController as? RepoListViewController else {
            fatalError("Invalid View Controller")
        }

		let wireframe: RepoListWireframeProtocol = RepoListWireframe()
        let presenter: RepoListPresenterProtocol = RepoListPresenter()
        let interactor: RepoListInteractorProtocol = RepoListInteractor()

        wireframe.navController = navController
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.presenter = presenter
        interactor.serviceClient = GithubServiceClient()


		return navController
	}

    func showAppInfo() {
        if let viewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "\(InfoViewController.self)") as? InfoViewController {
            viewController.modalPresentationStyle = .pageSheet
            navController?.present(viewController, animated: true)
        }
    }

    func showRepoDetail(login: String, repoName: String) {
        if let viewController = RepoDetailWireframe.create(withLogin: login, repoName: repoName) {
            viewController.modalPresentationStyle = .pageSheet
            navController?.present(viewController, animated: true)
        }
    }
}
