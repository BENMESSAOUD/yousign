//
//  SoapStructure.swift
//  YouSign
//
//  Created by Mahmoud Ben Messaoud on 31/05/2017.
//  Copyright © 2017 Mahmoud Ben Messaoud. All rights reserved.
//

import Foundation

class Envelope: Node {
    private var request: SoapRequest
    private var headers = Headers()
    private var body = Body()
    init(request: SoapRequest) {
        self.request = request
        self.headers.content = request.allHeaders
        self.body.action = request.action
    }

    var name: String {
        return XMLRequestKeys.envelope.rawValue
    }

    var attributes: [String : String]? {
        return [
            "xmlns:soapenv" : "\"http://schemas.xmlsoap.org/soap/envelope/\"",
            "xmlns:yous" : "\"http://www.yousign.com\"",
            "xmlns:xsi" : "\"xsi\""
        ]
    }

    var values: [String : String]? {
        return nil
    }

    var childs: [Node]? {
        return  [headers, body]
    }
}
