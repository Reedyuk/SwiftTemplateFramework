//
//  Urls.swift
//
//
//  Created by Andrew Reed on 09/08/2016.
//  Copyright © 2016. All rights reserved.
//

import Foundation
import UIKit

/// Enum representing the services
public enum ApiService: Int {
    case auth = 0  /// The authentication service
    case all
}

/// Used to generate the service urls.
public struct Urls {

    private static var localConfig: [ApiService: String] = [:]

    private static var devConfig: [ApiService: String] = [:]

    private static var releaseConfig: [ApiService: String] = [:]

    init() {
        Urls.resetConfig()
    }

    /*
     Example: Urls.changeLocalConfig(newLocalConfig:[.auth: "http://localhost"])
     */
    public static func changeLocalConfig(newLocalConfig: [ApiService: String]) {
        Urls.localConfig = newLocalConfig
        Urls.resetConfig()
    }

    public static func resetConfig() {
        Urls.devConfig = [.auth: Urls.Api.devAuthenticationUrl,
                     .all: Urls.Api.devBaseUrl]

        Urls.releaseConfig = [.auth: Urls.Api.prodAuthenticationUrl,
                             .all: Urls.Api.prodBaseUrl]
    }

    static func baseUrl(_ service: ApiService) -> String {
        var baseUrl = Urls.releaseConfig[service]!
        #if DEBUG
            baseUrl = Urls.devConfig[service]!
            if let local = Urls.localConfig[service] {
                baseUrl = local
            }
        #endif
        return baseUrl
    }

    /// The api related constants
    struct Api {
        /// The base url used for auth
        static let prodAuthenticationUrl = "https://www.google.com"
        static let devAuthenticationUrl = "https://www.google.com"
        static let localHostUrl = "http://localhost"

        /// The base url of the api services
        static let devBaseUrl = "https://www.google.com"
        static let prodBaseUrl = "https://www.google.com"
    }

    /// All user related requests from the Auth service are generated here.
    public struct AuthService {
        public static let loginUser =  "/login"
    }
}
