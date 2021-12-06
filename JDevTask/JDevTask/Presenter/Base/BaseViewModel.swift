
//
//  BaseViewModel.swift
//  JDevTask
//
//  Created by Tung Vu on 02/12/21.
//  Copyright © 2020 news. All rights reserved.
//

import Foundation
import RxSwift

protocol BaseViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output
}
