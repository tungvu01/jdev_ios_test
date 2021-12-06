//
//  Endpoint.swift
//  JDevTask
//
//  Created by Tung Vu on 02/12/21.
//  Copyright © 2020 news. All rights reserved.
//

import Foundation
import Alamofire

protocol Route {
    var method: HTTPMethod {get}
    var path: String  {get}
    var parametters: Parameters?  {get}
}

struct EndPoint {
    
    var route: Route
    var config: NetConnectionConfig
    var headers: [String: String]
    
    init(route apiRoute: Route,
         netConfig config: NetConnectionConfig,
         header requestHeader: [String: String] ){
        self.route = apiRoute
        self.config = config
        self.headers = requestHeader
    }
}

extension EndPoint: URLRequestConvertible {
    
    func asURLRequest() throws -> URLRequest {
        let url = try config.baseUrl.asURL()
        var urlRequest: URLRequest = URLRequest(url: url.appendingPathComponent(route.path))
        
        urlRequest.httpMethod = route.method.rawValue
        urlRequest.timeoutInterval = config.timeout
        // setting header
        for (key, value) in headers {
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }        
        if let parameters = route.parametters {
            do {
                urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            } catch {
                print("Encoding fail")
            }
        }
        return urlRequest
    }
}




