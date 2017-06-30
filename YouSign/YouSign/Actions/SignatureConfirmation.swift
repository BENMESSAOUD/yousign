//
//  SignatureConfirmation.swift
//  YouSign
//
//  Created by Mahmoud Ben Messaoud on 05/06/2017.
//  Copyright © 2017 Mahmoud Ben Messaoud. All rights reserved.
//

import Foundation

@objc public class SignatureConfirmation: Action, Requestable {

    public typealias ReturnType = Bool
    var signature: Signature
    var signer: Signer
    var token: String
    var _otp: String = kEmptyString
    var signatureImage: Data?

    @objc public init( environnement: Environement,  signature: Signature,  signer: Signer,  signatureImage: Data? = nil) {
        self.signature = signature
        self.signer = signer
        self.signatureImage = signatureImage
        self.token = signature.getToken(forSigner: signer).token
        super.init(environnement)
    }

    public var otp: String {
        get {
            return _otp
        }
        set{
            _otp = newValue
        }
    }
    override public var name: String{
        return XMLRequestKeys.confirmCosign.rawValue
    }

    override public var values: [String : String]? {
        var result = [ConfirmationRequestKeys.token.rawValue : token,
                      ConfirmationRequestKeys.otp.rawValue : otp]
        if let data = signatureImage {
            let base64 = data.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
            result[ConfirmationRequestKeys.image.rawValue] = base64
        }

        return result
    }

    override public var childs: [Node]?{
        return nil
    }

    override public var apiScheme: String {
        return ApiScheme.signature.rawValue
    }

    public func send(onSuccess: @escaping (Bool) -> Void, onFail: @escaping Requestable.OnFail) {
        sendRequest { (data, statusCode, err) in
            if let error = err {
                onFail(error, statusCode)
            }
            else if let data = data, statusCode == StatusCode.ok.rawValue {
                let xml = XML.parse(data)
                let result = self.getResult(actionName: .confirmSign, parser: xml)

                onSuccess(result.bool ?? false)
            }
            else {
                onFail(ConnectorError.server, StatusCode.serverError.rawValue)
            }
        }
    }
    
}
