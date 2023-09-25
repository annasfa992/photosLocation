

import Foundation
struct Social : Codable {
	let instagram_username : String?
	let portfolio_url : String?
	let twitter_username : String?
	let paypal_email : String?

	enum CodingKeys: String, CodingKey {

		case instagram_username = "instagram_username"
		case portfolio_url = "portfolio_url"
		case twitter_username = "twitter_username"
		case paypal_email = "paypal_email"
	}

	init(from decoder: Decoder) throws {
		let values = try? decoder.container(keyedBy: CodingKeys.self)
		instagram_username = try? values?.decodeIfPresent(String.self, forKey: .instagram_username)
		portfolio_url = try? values?.decodeIfPresent(String.self, forKey: .portfolio_url)
		twitter_username = try? values?.decodeIfPresent(String.self, forKey: .twitter_username)
		paypal_email = try? values?.decodeIfPresent(String.self, forKey: .paypal_email)
	}

}
