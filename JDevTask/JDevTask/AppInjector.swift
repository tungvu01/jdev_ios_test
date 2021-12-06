//
//  AppInjector.swift
//  JDevTask
//
//  Created by Tung Vu on 05/12/2021.
//

import Foundation
import Swinject

let injector: Container = {
    let container = Container()
    container.register(NetworkStatus.self) { _ in NetworkStatusImpl.shared}
    
    //API
    container.register(JetDevApi.self) { (r) -> JetDevApi in
        JetDevApiImpl(config: DefaultApiConfig(), networkStatus: r.resolve(NetworkStatus.self)!, tokenProvider: r.resolve(AccessTokenProvider.self)!)
    }
    
    //Repository
    container.register(AuthenRepository.self) { r in
        AuthenRepositoryImpl(userProvider: r.resolve(UserProfileProvider.self)!, jetDevApi: r.resolve(JetDevApi.self)!)
    }
    
    //Provider
    container.register(UserProfileProvider.self) { _ in UserProfileProviderImpl.shared}
    container.register(AccessTokenProvider.self) { _ in AccessTokenProviderImpl.shared}
    
    //Usecases
    container.register(LoginUseCase.self) { (r) in LoginUseCaseImpl(repository: r.resolve(AuthenRepository.self)!)}
    
    //ViewModel
    container.register(LoginViewModel.self) { (r) in
        LoginViewModel(with: r.resolve(LoginUseCase.self)!)
    }
    
    return container
}()

