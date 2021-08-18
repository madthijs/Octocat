//
//  Event.swift
//  Octocat
//
//  Created by Thijs Verboon on 18/08/2021.
//
import Foundation

enum EventType: String {
	case CommitCommentEvent
	case CreateEvent
	case DeleteEvent
	case ForkEvent
	case GollumEvent
	case IssueCommentEvent
	case IssuesEvent
	case MemberEvent
	case PublicEvent
	case PullRequestEvent
	case PullRequestReviewEvent
	case PullRequestReviewCommentEvent
	case PushEvent
	case ReleaseEvent
	case SponsorshipEvent
	case WatchEvent
	case Unknown
}

struct Event: Decodable {
	var type: EventType
	var actor: User
	var created: Date?

	enum CodingKeys: String, CodingKey {
		case type
		case actor
		case created = "created_at"
	}
}

extension Event {
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let typeString = try container.decode(String.self, forKey: .type)
		type = EventType(rawValue: typeString) ?? .Unknown

		actor = try container.decode(User.self, forKey: .actor)

		let dateString = try container.decode(String.self, forKey: .created)
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
		if let date = formatter.date(from: dateString) {
			created = date
		}
	}
}
