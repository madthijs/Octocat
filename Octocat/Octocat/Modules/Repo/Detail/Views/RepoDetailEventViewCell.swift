//
//  RepoListViewCell.swift
//  Octocat
//
//  Created by Thijs Verboon on 21/08/2021.
//
import UIKit

class RepoDetailEventViewCell: UICollectionViewCell {
    
    @IBOutlet weak var eventLabel: UILabel!

    func configure(_ viewModel: RepoDetailEventViewModel) {
        var text: String = "\(viewModel.name) by \(viewModel.authorName) at "
        if let created = viewModel.created {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none

            text += dateFormatter.string(from: created)
        } else {
            text += "someday"
        }

        eventLabel.text = text
    }
}

