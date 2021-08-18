//
//  ViewController.swift
//  Octocat
//
//  Created by Thijs Verboon on 18/08/2021.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.

		GithubServiceClient().fetchUser(withLogin: "JakeWharton")
		.done { user -> Void in
			print(user.name ?? "Unknown")
		}
		.catch { error in
			//Handle error or give feedback to the user
			print(error.localizedDescription)
		}

		GithubServiceClient().fetchRepos(withLogin: "JakeWharton")
		.done { repos -> Void in
			for repo in repos {
				print(repo.name)
			}
		}
		.catch { error in
			//Handle error or give feedback to the user
			print(error.localizedDescription)
		}

		GithubServiceClient().fetchEvents(withLogin: "JakeWharton", repoName: "butterknife")
		.done { events -> Void in
			for event in events {
				print("\(event.type) by \(event.actor.login) at \(event.created )")
			}
		}
		.catch { error in
			//Handle error or give feedback to the user
			print(error.localizedDescription)
		}
	}


}

