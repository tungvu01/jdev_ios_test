
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

struct LoginResponseModel {
    var result: Int
    var errorMessage: String
    var data: UserProfileModel?
    
    init() {
        self.result = 0
        self.errorMessage = ""
    }
    
    fileprivate enum LoginResponseModelKeys: String, CodingKey {
        case result          = "result"
        case errorMessage    = "error_message"
        case data            = "data"
    }
    fileprivate enum DataKeys: String, CodingKey {
        case user            = "user"
    }
}


extension LoginResponseModel: Decodable {
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: LoginResponseModelKeys.self)
        result =  (try? container?.decodeIfPresent(Int.self, forKey: .result)) ?? 0
        errorMessage = (try? container?.decodeIfPresent(String.self, forKey: .errorMessage)) ?? ""
        let dataContainer = try? container?.nestedContainer(keyedBy: DataKeys.self, forKey: .data)
        data = try? dataContainer?.decode(UserProfileModel.self, forKey: .user)
        
    }
}
