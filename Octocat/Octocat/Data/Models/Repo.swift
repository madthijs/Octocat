//
//  Repo.swift
//  Octocat
//
//  Created by Thijs Verboon on 18/08/2021.
//

struct Repo: Decodable {
	var name: String
	var description: String
    var owner: User

	enum CodingKeys: String, CodingKey {
		case name
		case description
        case owner
	}
}
