//
//  Credentials.swift
//  YouSign
//
//  Created by Mahmoud Ben Messaoud on 22/05/2017.
//  Copyright © 2017 Mahmoud Ben Messaoud. All rights reserved.
//

import Foundation

public protocol Credentials {

    var login: String {get}
    var password: String {get}
    var apiKey: String {get}
}
