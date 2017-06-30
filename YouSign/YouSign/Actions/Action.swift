//
//  Action.swift
//  YouSign
//
//  Created by Mahmoud Ben Messaoud on 29/05/2017.
//  Copyright © 2017 Mahmoud Ben Messaoud. All rights reserved.
//

import Foundation

public protocol Requestable {
    associatedtype ReturnType
    typealias OnSuccess = (ReturnType) -> Void
    typealias OnFail = (Error?, Int) -> Void
    func send(onSuccess: @escaping OnSuccess, onFail: @escaping OnFail)

}

@objc public class Action: NSObject, Node{

    private var environement: Environement
    internal var username: String
    internal var password: String
    internal var apiKey: String

    public init(_ environnement: Environement) {
        self.environement = environnement
        self.username = self.environement.credentials.login
        self.password = self.environement.credentials.password
        self.apiKey = self.environement.credentials.apiKey
    }

    var encryptedPassword: String {
        return "\(self.password.sha1)\(self.password.sha1)".sha1()
    }

    public var apiScheme: String {
        return kEmptyString
    }

    public var soapAction: String {
        return kEmptyString
    }

    public var url: URL? {
        return URL(string: "\(environement.apiURL.rawValue)\(apiScheme)")
    }

    public var name: String {
        return kEmptyString
    }

    public var attributes: [String : String]? {
        return nil
    }

    public var values: [String: String]? {
        return nil
    }
    
    public var childs:[Node]?  {
        return nil
    }

    internal func sendRequest( completion : @escaping (Data?, Int, Error?) -> Void) {
        let request = SoapRequest(action: self)
        guard let url = url, let xml =  request.envelope else {
            let error = NSError(domain: "Invalide request", code: 0, userInfo: nil)
            completion(nil, 404, error)
            return
        }
        print("URL : \(url) \n ENVELOPE : \(xml)")
        Connector().sendSoapRequest(url: url, xml: xml, soapAction: soapAction) { (data, statusCode, error) in
            completion (data, statusCode, error)
        }

    }

    func getResult(actionName: XMLResponseKeys, parser: XML.Accessor) -> XML.Accessor {
        let xmlReturn = parser[XMLResponseKeys.envelope.rawValue, XMLResponseKeys.body.rawValue, actionName.rawValue, XMLResponseKeys._return.rawValue]
        return xmlReturn
    }
}
