
import Foundation
struct Sponsor : Codable {
	let id : String?
	let updated_at : String?
	let username : String?
	let name : String?
	let first_name : String?
	let last_name : String?
	let twitter_username : String?
	let portfolio_url : String?
	let bio : String?
	let location : String?
	let links : Links?
	let profile_image : Profile_image?
	let instagram_username : String?
	let total_collections : Int?
	let total_likes : Int?
	let total_photos : Int?
	let accepted_tos : Bool?
	let for_hire : Bool?
	let social : Social?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case updated_at = "updated_at"
		case username = "username"
		case name = "name"
		case first_name = "first_name"
		case last_name = "last_name"
		case twitter_username = "twitter_username"
		case portfolio_url = "portfolio_url"
		case bio = "bio"
		case location = "location"
		case links = "links"
		case profile_image = "profile_image"
		case instagram_username = "instagram_username"
		case total_collections = "total_collections"
		case total_likes = "total_likes"
		case total_photos = "total_photos"
		case accepted_tos = "accepted_tos"
		case for_hire = "for_hire"
		case social = "social"
	}

	init(from decoder: Decoder) throws {
		let values = try? decoder.container(keyedBy: CodingKeys.self)
		id = try? values?.decodeIfPresent(String.self, forKey: .id)
		updated_at = try? values?.decodeIfPresent(String.self, forKey: .updated_at)
		username = try? values?.decodeIfPresent(String.self, forKey: .username)
		name = try? values?.decodeIfPresent(String.self, forKey: .name)
		first_name = try? values?.decodeIfPresent(String.self, forKey: .first_name)
		last_name = try? values?.decodeIfPresent(String.self, forKey: .last_name)
		twitter_username = try? values?.decodeIfPresent(String.self, forKey: .twitter_username)
		portfolio_url = try? values?.decodeIfPresent(String.self, forKey: .portfolio_url)
		bio = try? values?.decodeIfPresent(String.self, forKey: .bio)
		location = try? values?.decodeIfPresent(String.self, forKey: .location)
		links = try? values?.decodeIfPresent(Links.self, forKey: .links)
		profile_image = try? values?.decodeIfPresent(Profile_image.self, forKey: .profile_image)
		instagram_username = try? values?.decodeIfPresent(String.self, forKey: .instagram_username)
		total_collections = try? values?.decodeIfPresent(Int.self, forKey: .total_collections)
		total_likes = try? values?.decodeIfPresent(Int.self, forKey: .total_likes)
		total_photos = try? values?.decodeIfPresent(Int.self, forKey: .total_photos)
		accepted_tos = try? values?.decodeIfPresent(Bool.self, forKey: .accepted_tos)
		for_hire = try? values?.decodeIfPresent(Bool.self, forKey: .for_hire)
		social = try? values?.decodeIfPresent(Social.self, forKey: .social)
	}

}
