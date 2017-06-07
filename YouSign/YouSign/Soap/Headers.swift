//
//  Header.swift
//  YouSign
//
//  Created by Mahmoud Ben Messaoud on 31/05/2017.
//  Copyright © 2017 Mahmoud Ben Messaoud. All rights reserved.
//

import Foundation
class Headers: Node {
    public var content = [String: String]()

    var name: String {
        return XMLRequestKeys.header.rawValue
    }

    var attributes: [String : String]? {
        return nil
    }

    var values: [String: String]? {
        return content
    }
    
    var childs: [Node]? {
        return nil
    }


}
