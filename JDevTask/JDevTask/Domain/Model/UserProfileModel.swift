import RxSwift
import Combine

/*{
    "result": 1,
    "error_message": "",
    "data": {
        "user": {
            "user_id": 11,
            "user_name": "JetDevsUser",
            "user_profile_url": "https://www.jetdevs.com/wp-content/uploads/2020/11/worker-young.jpg",
            "created_at": "2020-12-07T04:30:49.822Z"
        }
    }
}*/

struct UserProfileModel {
    var userId: Int
    var userName: String
    var userProfileUrl: String
    var createAt: String
    
    init() {
        self.userId = -1
        self.userName = ""
        self.userProfileUrl = ""
        self.createAt = ""
    }
}

enum UserProfileModelKeys: String, CodingKey {
    case userId         = "user_id"
    case userName       = "user_name"
    case userProfileUrl = "user_profile_url"
    case createAt       = "created_at"
}

extension UserProfileModel: Codable {
    init(from decoder: Decoder) throws {
        do {
             let container = try decoder.container(keyedBy: UserProfileModelKeys.self)
            userId =  try container.decodeIfPresent(Int.self, forKey: .userId) ?? -1
            userName = try container.decodeIfPresent(String.self, forKey: .userName) ?? ""
            userProfileUrl = try container.decodeIfPresent(String.self, forKey: .userProfileUrl) ?? ""
            createAt = try container.decodeIfPresent(String.self, forKey: .createAt) ?? ""
        }
        catch {
            throw error
        }
    }
}


