//
//  AccessTokenProvider.swift
//  JDevTask
//
//  Created by Tung Vu on 06/12/2021.
//

import Foundation
protocol AccessTokenProvider {
    func getAccessToken() -> String?
    func saveAccessToken(_ token: String?)
}

class AccessTokenProviderImpl: AccessTokenProvider {
    
    private init(){}
    
    static let shared = AccessTokenProviderImpl()
    
    let accessTokenCachedKey: String = "ACCESS_TOKEN_CACHED_KEY"

    
    func getAccessToken() -> String? {
        let token = UserDefaults.standard.value(forKey: accessTokenCachedKey) as? String
        return token
    }

    
    func saveAccessToken(_ token: String?) {
        if let `token` = token {
            UserDefaults.standard.setValue(token, forKey: accessTokenCachedKey)
        }
    }
}
