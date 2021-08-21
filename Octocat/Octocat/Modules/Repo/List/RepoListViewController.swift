//
//  RepoListViewController.swift
//  Octocat
//
//  Created by Thijs Verboon on 19/08/2021.
//
import UIKit

class RepoListViewController: UICollectionViewController, RepoListViewProtocol {
	var presenter: RepoListPresenterProtocol?
    private var allRepos: [RepoListViewModel] = []
    private var filteredRepos: [RepoListViewModel] = [] //used for filter
    private var currentFilter: String?

    private let sectionInsets = UIEdgeInsets(
        top: 10.0,
        left: 10.0,
        bottom: 0.0,
        right: 10.0)

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

	override func viewDidLoad() {
		super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionHeadersPinToVisibleBounds = true
        }

        //navgation bar styling
        let navigationBarAppearence = UINavigationBarAppearance()
        navigationBarAppearence.configureWithOpaqueBackground()
        navigationBarAppearence.backgroundColor = .white
        navigationBarAppearence.shadowColor = .none

        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearence
        navigationController?.navigationBar.standardAppearance = navigationBarAppearence
        navigationController?.navigationBar.compactAppearance = navigationBarAppearence
	}

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }

    func configure(repos: [RepoListViewModel]) {
        let sorted = repos.sorted(by: { lhs, rhs in
            return lhs.name.compare(rhs.name, options: .caseInsensitive) == .orderedAscending
        })

        filteredRepos = sorted
        allRepos = sorted

        collectionView?.reloadData()
    }

    func configureAdditional(repos: [RepoListViewModel]) {
        //append the new data set and sort
        allRepos.append(contentsOf: repos)
        allRepos.sort(by: { lhs, rhs in
            return lhs.name.compare(rhs.name, options: .caseInsensitive) == .orderedAscending
        })

        //this will apply the current filter to the new data set
        if let currentFilter = currentFilter {
            filter(login: currentFilter)
        } else {
            removeFilter()
        }
    }

    func toggleActivityIndicator(on: Bool) {
        if on {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }

    @IBAction func addRepoButtonTapped(_ sender: Any) {
        presenter?.showAddLogin()
    }

    @IBAction func infoButtonTapped(_ sender: Any) {
        presenter?.showAppInfo()
    }
}

//UICollectionViewDataSource
extension RepoListViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredRepos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(RepoListViewCell.self)", for: indexPath) as! RepoListViewCell
        cell.configure(filteredRepos[indexPath.row])
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
      switch kind {
      case UICollectionView.elementKindSectionHeader:
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(RepoListHeaderView.self)", for: indexPath) as! RepoListHeaderView
        headerView.delegate = self
        headerView.configure(presenter?.logins ?? [])
        return headerView
      default:
        assert(false, "Invalid element type")
      }
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

protocol RepoListFilterDelegate: AnyObject {
    func filter(login: String)
    func removeFilter()
}

extension RepoListViewController: RepoListFilterDelegate {
    func filter(login: String) {
        currentFilter = login
        filteredRepos = allRepos.filter({$0.ownerLogin == login })
        collectionView?.reloadData()
    }

    func removeFilter() {
        currentFilter = nil
        filteredRepos = allRepos
        collectionView?.reloadData()
    }
}
