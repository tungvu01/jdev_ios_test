//
//  LoginViewController.swift
//  JDevTask
//
//  Created by Tung Vu on 04/12/2021.
//

import UIKit
import RxSwift

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var txtEmail:            UITextField!
    @IBOutlet weak var lbPasswordError:     UILabel!
    @IBOutlet weak var lbEmailError:        UILabel!
    @IBOutlet weak var txtPassword:         UITextField!
    @IBOutlet weak var btnLogin:            UIButton!
    
    fileprivate var viewModel: LoginViewModel           = injector.resolve(LoginViewModel.self)!
    fileprivate let disposeBag: DisposeBag              = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindInput()
        bindOutput()
        bindLoadingIndicator()
        bindLoginResult()
    }
}

//UI binding
extension LoginViewController {
    
    fileprivate func bindErrorTracker() {
        //        viewModel.errorTracker
        //            .
    }
    
    fileprivate func bindLoadingIndicator() {
        viewModel.loadingIndicator
            .drive(hud.rx.animation)
            .disposed(by: disposeBag)
    }
    
    fileprivate func bindLoginResult() {
        viewModel.loginResult!
            .subscribe(on: MainScheduler.instance)
            .subscribe { [weak self] event in
                let isLoginSuccess = (event.element?.result ?? 0) == 1
                if !isLoginSuccess {
                    self?.alert(message: event.element?.errorMessage ?? "Email or password is incorrect", action: {
                        self?.dismiss(animated: true, completion: nil)
                    })
                }
            }.disposed(by: disposeBag)
        
        viewModel.errorTracker
            .asObservable()
            .subscribe(on: MainScheduler.instance)
            .subscribe { [weak self] event in
                self?.alert(message: "Server Error Message", action: {
                    self?.dismiss(animated: true, completion: nil)
                })
            }.disposed(by: disposeBag)
    }
    
    fileprivate func bindOutput() {
        // email setting
        viewModel.isInputEmailValid
            .startWith(true)
            .drive(lbEmailError.rx.isHidden)
            .disposed(by: disposeBag)
        
        //password setting
        viewModel.isInputPasswordValid
            .startWith(true)
            .drive(lbPasswordError.rx.isHidden)
            .disposed(by: disposeBag)
        
        
        // login button setting
        viewModel.inputValid
            .startWith(false)
            .drive(btnLogin.rx
                    .isEnabled)
            .disposed(by: disposeBag)
    }
    
    fileprivate func bindInput() {
        viewModel.bindingInput(loginButtonClicked: btnLogin.rx
                                .tap
                                .asDriver(),
                               emailInputChanged:  txtEmail.rx
                                .text
                                .changed
                                .asDriver(),
                               passwordInputChanged: txtPassword.rx
                                .text
                                .changed
                                .asDriver())
    }
}
