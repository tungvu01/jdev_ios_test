//
//  LoginViewModel.swift
//  JDevTask
//
//  Created by Tung Vu on 04/12/2021.
//

import Foundation
import RxCocoa
import RxSwift
import Alamofire

struct LoginViewModel {
    
    private var loginUseCase:   LoginUseCase
    
    var loadingIndicator:               ActivityIndicator!
    var errorTracker:                   ErrorTracker!
    
    var isInputEmailValid:              Driver<Bool>!
    var isInputPasswordValid:           Driver<Bool>!
    var inputValid:                     Driver<Bool>!
    var loginResult:                    Observable<LoginResponseModel>?
    
    init(with usecase: LoginUseCase) {
        self.loginUseCase = usecase
        self.errorTracker = ErrorTracker()
        self.loadingIndicator = ActivityIndicator()
    }
    
    mutating func bindingInput( loginButtonClicked:         Driver<Void>,
                                emailInputChanged:          Driver<String?>!,
                                passwordInputChanged:       Driver<String?>) {
        isInputEmailValid = emailInputChanged
            .map { inputEmail in
                return isValidEmail(inputEmail)
            }.asDriver()
        
        isInputPasswordValid = passwordInputChanged
            .map { inputPassword in
                return isValidPassword(inputPassword)
            }.asDriver()
        
        inputValid = Driver.combineLatest(isInputEmailValid, isInputPasswordValid, resultSelector: { isEmailValid, isPasswordValid in
            return isEmailValid && isPasswordValid
        })
        
        // login handler
        let userInputs = Driver.combineLatest(emailInputChanged, passwordInputChanged, resultSelector: { email, password in
            return (email, password)
        })
        loginResult =  loginButtonClicked
            .withLatestFrom(userInputs)
            .filter({ email, password in
                return (email != nil && password != nil)
            })
            .flatMapLatest { [self] (email, password) -> Driver<LoginResponseModel> in
                return self.loginUseCase
                    .execute(with: email!, anddPassword: password!)
                    .trackActivity(loadingIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
                
            }
            .asObservable()
        
        
    }
}
