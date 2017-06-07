//
//  Soap.swift
//  YouSign
//
//  Created by Mahmoud Ben Messaoud on 29/05/2017.
//  Copyright © 2017 Mahmoud Ben Messaoud. All rights reserved.
//

import Foundation
public class SoapRequest {
    private var headers = [String:String]()
    private var xml: String?
    var action: Action

    public init(action: Action) {
        self.action = action
        headers[HeaderKeys.username.rawValue] = self.action.username
        headers[HeaderKeys.password.rawValue] = self.action.encryptedPassword
        headers[HeaderKeys.apikey.rawValue] = self.action.apiKey
        prepareRequest()
    }

    func appendHeader(key: String, value: String) {
        if let _ = HeaderKeys(rawValue: key) {
            return
        }

        headers[key] = value
    }

    func removeHeader(forkey: String) {
        if let _ = HeaderKeys(rawValue: forkey) {
            return
        }

        headers.removeValue(forKey: forkey)
    }

    var allHeaders: [String:String] {
        return headers
    }

    public var envelope: String? {
        return xml
    }

    func prepareRequest(){
        let envelope = Envelope(request: self)
        self.xml = envelope.xml
    }
}
