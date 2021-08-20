//
//  RepoListViewController.swift
//  Octocat
//
//  Created by Thijs Verboon on 19/08/2021.
//
import UIKit
import Differ

class RepoListViewController: UICollectionViewController, RepoListViewProtocol {
	var presenter: RepoListPresenterProtocol?
    private var dataSource: [RepoListViewModel] = []
    private let sectionInsets = UIEdgeInsets(
        top: 0.0,
        left: 10.0,
        bottom: 0.0,
        right: 10.0)

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

	override func viewDidLoad() {
		super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
	}

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }

    func configure(repos: [RepoListViewModel]) {
        collectionView?.animateItemChanges(oldData: dataSource, newData: repos, updateData: { self.dataSource = repos })
    }

    func toggleActivityIndicator(on: Bool) {
        if on {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}

//UICollectionViewDataSource
extension RepoListViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RepoListCell", for: indexPath) as! RepoListViewCell
        cell.configure(dataSource[indexPath.row])
        return cell
    }
}

extension RepoListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - sectionInsets.left - sectionInsets.right, height: 120)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
