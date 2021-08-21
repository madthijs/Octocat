//
//  RepoDetailViewController.swift
//  Octocat
//
//  Created by Thijs Verboon on 19/08/2021.
//
import UIKit

class RepoDetailViewController: UIViewController, RepoDetailViewProtocol {
    @IBOutlet fileprivate weak var collectionView: UICollectionView!

	var presenter: RepoDetailPresenterProtocol?
    private var events: [RepoDetailEventViewModel] = []
    private var viewModel: RepoDetailViewModel?

    private let sectionInsets = UIEdgeInsets(
        top: 10.0,
        left: 10.0,
        bottom: 0.0,
        right: 10.0)

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var repoLabel: UILabel!
    @IBOutlet weak var watchCount: UILabel!
    @IBOutlet weak var forkCount: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var webButton: UIButton!
    @IBOutlet weak var noEventsFoundLabel: UILabel!

	override func viewDidLoad() {
		super.viewDidLoad()

        detailView.alpha = 0

        noEventsFoundLabel.isHidden = true

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionHeadersPinToVisibleBounds = true
        }
	}

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }

    func configure(events: [RepoDetailEventViewModel]) {
        let sorted = events.sorted(by: { lhs, rhs in
            return lhs.created?.timeIntervalSince1970 ?? 0 > rhs.created?.timeIntervalSince1970 ?? 0
        })

        self.events = sorted
        noEventsFoundLabel.isHidden = !sorted.isEmpty

        collectionView?.reloadData()
    }

    func configure(repo: RepoDetailViewModel) {
        viewModel = repo

        repoLabel.text = repo.ownerLogin
        descriptionLabel.text = repo.description
        loginLabel.text = repo.ownerLogin
        forkCount.text = NumberFormatter().string(from: NSNumber(value: repo.forkCount))
        watchCount.text = NumberFormatter().string(from: NSNumber(value: repo.watcherCount))

        webButton.setTitle(repo.url?.absoluteString.replacingOccurrences(of: "https://", with: ""), for: .normal)


        detailView.layoutIfNeeded()
        detailView.addBottomShadow()

        //load image
        avatarImage.loadImageFrom(url: repo.ownerAvatarURL)
            .done({ image in
                self.avatarImage.image = image
            })
            .catch { error in
                //default placeholder
                self.avatarImage.image = UIImage(named: "avatar")
            }
            .finally {
                //fade in configured view
                UIView.animate(withDuration: 0.5) {
                    self.detailView.alpha = 1
                }
            }
    }

    func toggleActivityIndicator(on: Bool) {
        if on {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }

    @IBAction func didTapWebButton(_ sender: Any) {
        if let url = viewModel?.url {
            presenter?.openUrl(url: url)
        }
    }

    @IBAction func didTapCloseButton(_ sender: Any) {
        dismiss(animated: true)
    }
}

//UICollectionViewDataSource
extension RepoDetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(RepoDetailEventViewCell.self)", for: indexPath) as! RepoDetailEventViewCell
        cell.configure(events[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
      switch kind {
      case UICollectionView.elementKindSectionHeader:
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "EventsListHeader", for: indexPath)
        return headerView
      default:
        assert(false, "Invalid element type")
      }
    }
}

extension RepoDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - sectionInsets.left - sectionInsets.right, height: 24)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
