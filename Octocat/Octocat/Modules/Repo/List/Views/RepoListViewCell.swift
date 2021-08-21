//
//  RepoListViewCell.swift
//  Octocat
//
//  Created by Thijs Verboon on 20/08/2021.
//
import UIKit

class RepoListViewCell: UICollectionViewCell {
    @IBOutlet weak var ownerLogin: UILabel!
    @IBOutlet weak var repoName: UILabel!

    @IBOutlet weak var forkCount: UILabel!
    @IBOutlet weak var watchCount: UILabel!

    @IBOutlet weak var avatar: UIImageView!

    func configure(_ viewModel: RepoListViewModel) {
        ownerLogin.text = viewModel.ownerLogin
        repoName.text = viewModel.name

        forkCount.text = NumberFormatter().string(from: NSNumber(value: viewModel.forkCount))
        watchCount.text = NumberFormatter().string(from: NSNumber(value: viewModel.watcherCount))

        avatar.image = nil
        avatar.loadImageFrom(url: viewModel.ownerAvatarURL)
            .done({ image in
                self.avatar.image = image
            })
            .catch { error in
                //default placeholder
                self.avatar.image = UIImage(named: "avatar")
            }
    }
}

