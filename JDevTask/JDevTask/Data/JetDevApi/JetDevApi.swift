//
//  ExchangeApi.swift
//  JDevTask
//
//  Created by Tung Vu on02/12/21.
//  Copyright © 2020 news. All rights reserved.
//

import Foundation

enum APIReuslt<T: Decodable> {
    case success(T)
    case failure(Exception)
}

typealias ApiCompletion<T: Decodable> = (APIReuslt<T>) -> Void

protocol JetDevApi {
    func login(email: String, password: String, completion:ApiCompletion<LoginResponseModel>?)
    
}

struct JetDevApiImpl: JetDevApi {
    
    private var networkStatus:          NetworkStatus?
    private var apiConfig:              DefaultApiConfig
    private var accessTokenProfiver:    AccessTokenProvider?
    
    init(config: DefaultApiConfig, networkStatus: NetworkStatus?, tokenProvider: AccessTokenProvider?) {
        self.apiConfig = config
        self.networkStatus = networkStatus
        self.accessTokenProfiver = tokenProvider
    }
    
    func login(email: String, password: String, completion: ApiCompletion<LoginResponseModel>?) {
        NetConnection(networkStatus: networkStatus)
            .request(endpoint:
                        EndPoint(route: JetDevApiRoutes.login(email: email, password: password), netConfig: apiConfig, header: [:])) { result in
                switch result {
                case .success(let data, let header):
                    if let headerDics = header?.dictionary, let token = headerDics["X-Acc"] {
                        self.accessTokenProfiver?.saveAccessToken(token)
                    }
                    if let res = try? LoginResponseModel.decode(data: data)  {
                        completion?(.success(res))
                    } else {
                        let error  = (try? ApiException.decode(data: data)) ?? ApiException(
                            message: UNKNOWN_ERROR_MESSAGE,
                            code: "",
                            httpCode: 200,
                            status: false)
                        completion?(.failure(error))
                    }
                    break
                case .failure(let error):
                    completion?(.failure(error))
                    break
                }
            }
    }
}
