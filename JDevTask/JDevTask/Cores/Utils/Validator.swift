//
//  Validator.swift
//  JDevTask
//
//  Created by Tung Vu on 04/12/2021.
//

import Foundation

let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
let passwordPattern = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)"

func isValidEmail(_ email: String?) -> Bool {
    guard let `email` = email else {
        return false
    }
    
    let regex = try! NSRegularExpression(
        pattern: emailPattern,
        options: []
    )
    let sourceRange = NSRange(
        email.startIndex..<email.endIndex,
        in: email
    )

    let result = regex.matches(
        in: email,
        options: [],
        range: sourceRange
    )
    return result.count > 0
}

func isValidPassword(_ password: String?) -> Bool {
    guard let `password` = password  else {
        return false
    }
    let regex = try! NSRegularExpression(
        pattern: passwordPattern,
        options: []
    )
    let sourceRange = NSRange(
        password.startIndex..<password.endIndex,
        in: password
    )

    let result = regex.matches(
        in: password,
        options: [],
        range: sourceRange
    )
    return result.count > 0
}
