//
//  Signer.swift
//  YouSign
//
//  Created by Mahmoud Ben Messaoud on 04/06/2017.
//  Copyright © 2017 Mahmoud Ben Messaoud. All rights reserved.
//

import Foundation
@objc public class Signer: NSObject, Node {

    public var firstName: String
    public var lastName: String
    public var mail: String?
    public var phone: String?

    @objc public  init(firstName: String,lastName: String, mail: String? , phone: String?) {
        self.firstName = firstName
        self.lastName = lastName
        self.mail = mail
        self.phone = phone
    }

    public var name: String {
        return SignerKeys.name.rawValue
    }

    public var attributes: [String : String]? {
        return nil
    }

    public var values: [String: String]? {
        var result = [
            SignerKeys.firstname.rawValue : firstName,
            SignerKeys.lastname.rawValue : lastName
        ]
        if let mail = mail {
            result[SignerKeys.mail.rawValue] = mail
        }
        if let phone = phone {
            result[SignerKeys.phone.rawValue] = phone
        }
        return result
    }

    public var childs: [Node]? {
        return nil
    }
}
