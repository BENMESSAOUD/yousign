//
//  VisibleOptions.swift
//  YouSign
//
//  Created by Mahmoud Ben Messaoud on 06/07/2017.
//  Copyright © 2017 Mahmoud Ben Messaoud. All rights reserved.
//

import Foundation

internal class VisibleOptions: Node {
    var isVisible = false
    var page = 1
    var position: String?
    var mail: String?
    public var name: String {
        return VisibleOptionsKeys.name.rawValue
    }

    public var attributes: [String : String]? {
        return nil
    }

    public var values: [String: String]? {
        var result = [
            VisibleOptionsKeys.isVisible.rawValue : "\(isVisible)",
            VisibleOptionsKeys.page.rawValue : "\(page)"
        ]
        if let position = position {
            result[VisibleOptionsKeys.position.rawValue] = position
        }

        if let mail = mail {
            result[VisibleOptionsKeys.mail.rawValue] = mail
        }
        return result
    }

    public var childs: [Node]? {
        return nil
    }
}
