//
//  User.swift
//  Octocat
//
//  Created by Thijs Verboon on 18/08/2021.
//
import Foundation

struct User: Decodable {
	var login: String
	var name: String?
	var company: String?
	var url: URL
	var avatarUrl: URL

	enum CodingKeys: String, CodingKey {
		case login
		case name
		case company
		case url
		case avatarUrl = "avatar_url"
	}
}
