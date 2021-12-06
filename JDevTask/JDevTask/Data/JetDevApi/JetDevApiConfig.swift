//
//  ExchangeApi.swift
//  JDevTask
//
//  Created by Tung Vu on 02/12/21.
//  Copyright © 2020 news. All rights reserved.
//

import Foundation

let JETDEV_API_BASE_URL     = "https://jetdevs.mocklab.io/"
let DEFAULT_API_TIMEOUT     = 30.0

struct DefaultApiConfig: NetConnectionConfig {
    var baseUrl: String     = JETDEV_API_BASE_URL
    var timeout: Double     = DEFAULT_API_TIMEOUT
}
