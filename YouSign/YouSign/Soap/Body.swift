//
//  Body.swift
//  YouSign
//
//  Created by Mahmoud Ben Messaoud on 31/05/2017.
//  Copyright © 2017 Mahmoud Ben Messaoud. All rights reserved.
//

import Foundation

class Body: Node {
    public var action: Action?

    var name: String {
        return XMLRequestKeys.body.rawValue
    }

    var attributes: [String : String]? {
        return nil
    }

    var values: [String: String]? {
        return nil
    }

    var childs: [Node]? {
        guard let action = self.action else {
            return nil
        }
        return [action]
    }
    
}
