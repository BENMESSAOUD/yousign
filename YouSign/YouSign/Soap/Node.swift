//
//  Node.swift
//  YouSign
//
//  Created by Mahmoud Ben Messaoud on 29/05/2017.
//  Copyright © 2017 Mahmoud Ben Messaoud. All rights reserved.
//

import Foundation
public protocol Node {
    var name: String {get}
    var values: [String:String]? {get}
    var childs: [Node]? {get}
    var attributes: [String:String]? {get}
}
