//
//  Routes.swift
//  JDevTask
//
//  Created by Tung Vu on 02/12/21.
//  Copyright © 2020 news. All rights reserved.
//

import Foundation
import Alamofire

enum JetDevApiRoutes: Route {
    
    case login(email: String, password: String)
    
    var method: HTTPMethod {
        switch self {
        case .login(_,_):
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .login(_,_):
            return "login"
        }
    }
    
    var parametters: Parameters? {
        switch self {
        case .login(let email, let password):
            //return ["email":"test@jetdevs.com", "password": "Jetdevs2021"]
            return ["email":email,
                    "password": password]
        }
    }
}
