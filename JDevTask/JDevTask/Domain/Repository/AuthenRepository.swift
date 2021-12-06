//
//  AuthenRepository.swift
//  JDevTask
//
//  Created by Tung Vu on 04/12/2021.
//

import Foundation
import RxSwift

protocol AuthenRepository {
    func login(email: String, password: String) -> Observable<LoginResponseModel>
}
