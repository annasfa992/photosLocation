
import Foundation
struct PhotosResponseModel: Codable {
	let id : String?
	let slug : String?
	let created_at : String?
	let updated_at : String?
	let promoted_at : String?
	let width : Int?
	let height : Int?
	let color : String?
	let blur_hash : String?
	let description : String?
	let alt_description : String?
	let breadcrumbs : [String]?
	let urls : Urls?
	let links : Links?
	let likes : Int?
	let liked_by_user : Bool?
	let current_user_collections : [String]?
	let sponsorship : Sponsorship?
	let user : User?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case slug = "slug"
		case created_at = "created_at"
		case updated_at = "updated_at"
		case promoted_at = "promoted_at"
		case width = "width"
		case height = "height"
		case color = "color"
		case blur_hash = "blur_hash"
		case description = "description"
		case alt_description = "alt_description"
		case breadcrumbs = "breadcrumbs"
		case urls = "urls"
		case links = "links"
		case likes = "likes"
		case liked_by_user = "liked_by_user"
		case current_user_collections = "current_user_collections"
		case sponsorship = "sponsorship"
		case user = "user"
	}

	init(from decoder: Decoder) throws {
		let values = try? decoder.container(keyedBy: CodingKeys.self)
		id = try? values?.decodeIfPresent(String.self, forKey: .id)
		slug = try? values?.decodeIfPresent(String.self, forKey: .slug)
		created_at = try? values?.decodeIfPresent(String.self, forKey: .created_at)
		updated_at = try? values?.decodeIfPresent(String.self, forKey: .updated_at)
		promoted_at = try? values?.decodeIfPresent(String.self, forKey: .promoted_at)
		width = try? values?.decodeIfPresent(Int.self, forKey: .width)
		height = try? values?.decodeIfPresent(Int.self, forKey: .height)
		color = try? values?.decodeIfPresent(String.self, forKey: .color)
		blur_hash = try? values?.decodeIfPresent(String.self, forKey: .blur_hash)
		description = try? values?.decodeIfPresent(String.self, forKey: .description)
		alt_description = try? values?.decodeIfPresent(String.self, forKey: .alt_description)
		breadcrumbs = try? values?.decodeIfPresent([String].self, forKey: .breadcrumbs)
		urls = try? values?.decodeIfPresent(Urls.self, forKey: .urls)
		links = try? values?.decodeIfPresent(Links.self, forKey: .links)
		likes = try? values?.decodeIfPresent(Int.self, forKey: .likes)
		liked_by_user = try? values?.decodeIfPresent(Bool.self, forKey: .liked_by_user)
		current_user_collections = try? values?.decodeIfPresent([String].self, forKey: .current_user_collections)
		sponsorship = try? values?.decodeIfPresent(Sponsorship.self, forKey: .sponsorship)
		user = try? values?.decodeIfPresent(User.self, forKey: .user)
	}

}
