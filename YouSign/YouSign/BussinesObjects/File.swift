//
//  File.swift
//  YouSign
//
//  Created by Mahmoud Ben Messaoud on 04/06/2017.
//  Copyright © 2017 Mahmoud Ben Messaoud. All rights reserved.
//

import Foundation
@objc public class File: NSObject, Node {
    public var fileName: String
    public var content: Data
    public var password: String?

    @objc public init(name: String, content: Data, password: String? = nil) {
        self.fileName = name
        self.content = content
        self.password = password
    }

    public var name: String {
        return FileKeys.name.rawValue
    }

    public var attributes: [String : String]? {
        return nil
    }

    public var values: [String: String]? {
        var result = [
            FileKeys.filename.rawValue : fileName,
            FileKeys.content.rawValue : encodedContent
        ]
        if let password = password {
            result[FileKeys.pdfPassword.rawValue] = password
        }
        return result
    }

    public var childs: [Node]? {
        return nil
    }
    
    private var encodedContent: String {
        let base64 = content.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        return base64
    }
}
