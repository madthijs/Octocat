//
//  Repo.swift
//  Octocat
//
//  Created by Thijs Verboon on 18/08/2021.
//

import Foundation

struct Repo: Decodable {
	var name: String
	var description: String?
    var owner: User
    var watchers: Int
    var forks: Int
    var url: URL?

	enum CodingKeys: String, CodingKey {
		case name
		case description
        case owner
        case watchers
        case forks
        case url = "html_url"
	}
}
