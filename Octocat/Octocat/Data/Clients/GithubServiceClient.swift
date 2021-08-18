//
//  GithubServiceClient.swift
//  Octocat
//
//  Created by Thijs Verboon on 18/08/2021.
//

import PromiseKit
import Alamofire

class GithubServiceClient: GithubServiceClientProtocol {
	private var baseUrl: String = "https://api.github.com"

	func fetchUser(withLogin login: String) -> Promise<User> {
		return Promise { seal in
			AF.request("\(baseUrl)/users/\(login)")
				.validate()
				.responseDecodable(of: User.self) { (response) in
					switch response.result {
					case .success(let value):
						seal.fulfill(value)
					case .failure(let error):
						seal.reject(error)
					}
				}
		}
	}

	func fetchRepos(withLogin login: String) -> Promise<[Repo]> {
		return Promise { seal in
			AF.request("\(baseUrl)/users/\(login)/repos")
				.validate()
				.responseDecodable(of: [Repo].self) { (response) in
					switch response.result {
					case .success(let value):
						seal.fulfill(value)
					case .failure(let error):
						seal.reject(error)
					}
				}
		}
	}

	func fetchRepo(withLogin login: String, name: String) -> Promise<Repo> {
		return Promise { seal in
			AF.request("\(baseUrl)/repos/\(login)/\(name)")
				.validate()
				.responseDecodable(of: Repo.self) { (response) in
					switch response.result {
					case .success(let value):
						seal.fulfill(value)
					case .failure(let error):
						seal.reject(error)
					}
				}
		}
	}

	func fetchEvents(withLogin login: String, repoName name: String) -> Promise<[Event]> {
		return Promise { seal in
			AF.request("\(baseUrl)/repos/\(login)/\(name)/events")
				.validate()
				.responseDecodable(of: [Event].self) { (response) in
					switch response.result {
					case .success(let value):
						seal.fulfill(value)
					case .failure(let error):
						seal.reject(error)
					}
				}
		}
	}
}
