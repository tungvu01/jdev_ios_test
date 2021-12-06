//
//  AuthenRepositoryImpl.swift
//  JDevTask
//
//  Created by Tung Vu on 04/12/2021.
//

import Foundation
import RxSwift

struct AuthenRepositoryImpl {
    private var provider:   UserProfileProvider
    private var api:        JetDevApi
    
    init(userProvider: UserProfileProvider, jetDevApi: JetDevApi) {
        self.provider = userProvider
        self.api = jetDevApi
    }
}

extension AuthenRepositoryImpl: AuthenRepository {
    func login(email: String, password: String) -> Observable<LoginResponseModel> {
        let observable = Observable<LoginResponseModel>
            .create { (observer) -> Disposable in
                api.login(email: email, password: password) { result in
                    switch result {
                    case .success(let  response):
                        if let profile = response.data {
                            self.provider.saveUserProfile(profile: profile)
                        }
                        observer.onNext(response)
                        observer.onCompleted()
                    case .failure(let exception):
                        observer.onError(exception)
                    }
                }
                return Disposables.create()
        }
        return observable
    }
}
