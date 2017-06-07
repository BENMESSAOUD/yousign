//
//  Connect.swift
//  YouSign
//
//  Created by Mahmoud Ben Messaoud on 29/05/2017.
//  Copyright © 2017 Mahmoud Ben Messaoud. All rights reserved.
//

import Foundation
import SwiftyXMLParser

public class Connect : Action, Requestable{
    public typealias ReturnType = Bool
    override public var name: String{
        return XMLRequestKeys.connect.rawValue
    }

    override public var childs: [Node]?{
        return nil
    }

    override public var apiScheme: String {
        return ApiScheme.authentification.rawValue
    }

    override public var soapAction: String {
        return "AuthenticationWS"
    }

    public func send(onSuccess: @escaping (Bool) -> Void, onFail: @escaping Requestable.OnFail) {
        sendRequest { (data, statusCode, err) in
            if let error = err {
                onFail(error, statusCode)
            }
            else if let data = data, statusCode == StatusCode.ok.rawValue {
                let xml = XML.parse(data)
                let result = self.getResult(actionName: .connect, parser: xml)

                onSuccess(result.bool ?? false)
            }
            else {
                onFail(ConnectorError.server, StatusCode.serverError.rawValue)
            }
        }
    }
}
