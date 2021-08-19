//
//  RepoListViewController.swift
//  Octocat
//
//  Created by Thijs Verboon on 19/08/2021.
//
import UIKit

class RepoListViewController: UIViewController, RepoListViewProtocol {
	var presenter: RepoListPresenterProtocol?

	override func viewDidLoad() {
		super.viewDidLoad()

		self.navigationController?.navigationBar.prefersLargeTitles = true
	}
}
