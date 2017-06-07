//
//  Node+Extension.swift
//  YouSign
//
//  Created by Mahmoud Ben Messaoud on 31/05/2017.
//  Copyright © 2017 Mahmoud Ben Messaoud. All rights reserved.
//

import Foundation

extension Node {
    var stringAttribute: String {
        var result = kEmptyString
        guard let allAttribute = self.attributes else {
            return result
        }

        for (key, value) in allAttribute {
            result.append(" \(key)=\(value)")
        }

        return result
    }

    var xml: String {
        var result = kEmptyString

        if (self.childs == nil && self.values == nil) {
            result.append("<\(self.name)")
            result.append("\(self.stringAttribute)/>")
            return result
        }
        result.append("<\(self.name)")
        result.append("\(self.stringAttribute)>")
        if let allValues = self.values {
            for (key, value) in allValues {
                result.append("<\(key)>\(value)</\(key)>")
            }
        }
        if let nodes = self.childs {
            for node in nodes {
                result.append(node.xml)
            }
        }
        result.append("</\(self.name)>")
        return result
    }
}
