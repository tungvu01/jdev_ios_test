//
//  NetConnectionConfig.swift
//  JDevTask
//
//  Created by Tung Vu on 02/12/21.
//  Copyright © 2020 news. All rights reserved.
//

import Foundation

protocol NetConnectionConfig {
    var baseUrl: String {get set}
    var timeout: Double { get set}
}
