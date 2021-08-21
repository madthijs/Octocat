//
//  RepoListHeaderView.swift
//  Octocat
//
//  Created by Thijs Verboon on 20/08/2021.
//

import UIKit

class RepoListHeaderView: UICollectionReusableView {
    weak var delegate: RepoListFilterDelegate?

    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var resetButton: UIButton!

    private var isConfigured: Bool = false

    private var selectedFilter: String? {
        didSet {
            if let filter = selectedFilter {
                delegate?.filter(login: filter)
            } else {
                delegate?.removeFilter()
            }
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        for view in buttonStackView.arrangedSubviews[1...] {
            view.removeFromSuperview()
        }
    }

    func configure(_ logins: [String]) {
        self.addBottomShadow()
        resetButton.layer.borderColor = UIColor.systemBlue.cgColor

        //add filter buttons
        for login in logins {
            let button = UIButton()

            button.setTitle(login, for: .normal)
            button.setTitleColor(.systemBlue, for: .normal)
            button.layer.cornerRadius = resetButton.layer.cornerRadius
            button.layer.borderWidth = resetButton.layer.borderWidth
            button.layer.borderColor = UIColor.systemBlue.cgColor
            button.contentEdgeInsets = resetButton.contentEdgeInsets
            button.titleLabel?.font = resetButton.titleLabel?.font
            button.backgroundColor = .none

            button.addTarget(self, action: #selector(didTapFilterButton), for: .touchUpInside)
            buttonStackView.addArrangedSubview(button)

            if selectedFilter == login {
                makeActive(button)
            }
        }

        if !isConfigured {
            makeActive(resetButton)
            isConfigured = true
        }
    }

    private func makeActive(_ button: UIButton) {
        for view in buttonStackView.arrangedSubviews {
            if let btn = view as? UIButton {
                btn.backgroundColor = .none
                btn.setTitleColor(.systemBlue, for: .normal)
            }
        }

        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
    }

    @IBAction func didTapRemoveFilter(_ sender: Any) {
        selectedFilter = nil
        makeActive(resetButton)
    }

    @objc func didTapFilterButton(sender: UIButton!) {
        selectedFilter = sender.titleLabel?.text
        makeActive(sender)
    }
}
