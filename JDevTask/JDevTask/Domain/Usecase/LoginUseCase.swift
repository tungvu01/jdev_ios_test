//
//  LoginUseCase.swift
//  JDevTask
//
//  Created by Tung Vu on 04/12/2021.
//

import Foundation
import RxSwift

protocol LoginUseCase {
    func execute(with email: String, anddPassword password: String) -> Observable<LoginResponseModel>
}

struct LoginUseCaseImpl: LoginUseCase {
    func execute(with email: String, anddPassword password: String) -> Observable<LoginResponseModel> {
        return repository.login(email: email, password: password)
    }
    
    
    private var repository: AuthenRepository
    
    init(repository: AuthenRepository) {
        self.repository = repository
    }
}
