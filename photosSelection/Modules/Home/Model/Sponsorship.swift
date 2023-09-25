
import Foundation
struct Sponsorship : Codable {
	let impression_urls : [String]?
	let tagline : String?
	let tagline_url : String?
	let sponsor : Sponsor?

	enum CodingKeys: String, CodingKey {

		case impression_urls = "impression_urls"
		case tagline = "tagline"
		case tagline_url = "tagline_url"
		case sponsor = "sponsor"
	}

	init(from decoder: Decoder) throws {
		let values = try? decoder.container(keyedBy: CodingKeys.self)
		impression_urls = try? values?.decodeIfPresent([String].self, forKey: .impression_urls)
		tagline = try? values?.decodeIfPresent(String.self, forKey: .tagline)
		tagline_url = try? values?.decodeIfPresent(String.self, forKey: .tagline_url)
		sponsor = try? values?.decodeIfPresent(Sponsor.self, forKey: .sponsor)
	}

}
