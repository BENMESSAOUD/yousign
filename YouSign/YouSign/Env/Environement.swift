//
//  Environement.swift
//  YouSign
//
//  Created by Mahmoud Ben Messaoud on 22/05/2017.
//  Copyright © 2017 Mahmoud Ben Messaoud. All rights reserved.
//

import Foundation
public enum Target {
    case demo
    case production
}

enum API_URL: String{
    case demoURL = "https://apidemo.yousign.fr:8181/"
    case productionURL = "https://api.yousign.fr:8181/"
}

public struct Environement {
    var target: Target
    var credentials: Credentials
    private var api_Url: API_URL

    public init(_ target: Target = .demo, credential: Credentials) {
        self.target = target
        self.credentials = credential
        switch target {
        case .demo:
            self.api_Url = .demoURL
        case .production :
            self.api_Url = .productionURL
        }
    }

    var apiURL: API_URL {
        return api_Url
    }
}
