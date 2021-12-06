//
//  CurrencyProvider.swift
//  JDevTask
//
//  Created by Tung Vu on 02/12/21.
//  Copyright © 2020 news. All rights reserved.
//

import Foundation

protocol UserProfileProvider {
    func getCachedUserProfile() -> UserProfileModel?
    func saveUserProfile(profile: UserProfileModel)
}

class UserProfileProviderImpl: UserProfileProvider {
    
    private init(){}
    
    static let shared = UserProfileProviderImpl()
    
    let userProfileCachedKey: String = "USER_PROFILE_CACHED_KEY"
    private var _cachedProfile: UserProfileModel?

    
    func getCachedUserProfile() -> UserProfileModel? {
        if(_cachedProfile == nil) {
            if let jsonData = UserDefaults.standard.value(forKey: userProfileCachedKey) as? String,
               let data = jsonData.data(using: .utf8)  {
                _cachedProfile = try? UserProfileModel.decode(data: data)
            }
        }
        return _cachedProfile;
    }

    
    func saveUserProfile(profile: UserProfileModel) {
        if let jsonString = profile.asJsonString() {
            UserDefaults.standard.setValue(jsonString, forKey: userProfileCachedKey)
        }
    }
}
