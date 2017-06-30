//
//  SignedFiles.swift
//  YouSign
//
//  Created by Mahmoud Ben Messaoud on 06/06/2017.
//  Copyright © 2017 Mahmoud Ben Messaoud. All rights reserved.
//

import Foundation
import SwiftyXMLParser
@objc public class SignedFiles: Action, Requestable {
    public typealias ReturnType = [File]
    var signature: Signature
    var idFile: String?
    var signer: Signer?
    @objc public init(environement: Environement, signature: Signature) {
        self.signature = signature
        super.init(environnement: environement)
    }

    override public var name: String{
        return XMLRequestKeys.signedFile.rawValue
    }

    override public var values: [String : String]? {
        var result = [SignatureResponseKeys.idDemand.rawValue : signature.id]
        if let file = idFile {
            result[SignatureResponseKeys.idFile.rawValue] =  file
        }
        if let signer = signer {
            let signerToken = signature.getToken(forSigner: signer)
            result[SignatureResponseKeys.token.rawValue] = signerToken.token
        }

        return result

    }

    override public var childs: [Node]?{
        return nil
    }

    override public var apiScheme: String {
        return ApiScheme.signature.rawValue
    }

    public func send(onSuccess: @escaping ([File]) -> Void, onFail: @escaping Requestable.OnFail) {
        sendRequest { (data, statusCode, err) in
            if let error = err {
                onFail(error, statusCode)
            }
            else if let data = data, statusCode == StatusCode.ok.rawValue {
                let xml = XML.parse(data)
                let result =  xml[XMLResponseKeys.envelope.rawValue, XMLResponseKeys.body.rawValue, XMLResponseKeys.signedFile.rawValue]
                let files = self.getFiles(parser: result)
                if files.count > 0 {
                    onSuccess(files)
                }
                else {
                    onFail(ConnectorError.server, StatusCode.serverError.rawValue)
                }
            }
            else {
                onFail(ConnectorError.server, StatusCode.serverError.rawValue)
            }
        }
    }

    private func getFiles(parser: XML.Accessor) -> [File] {
        var result = [File]()
        if let allElements = parser.element?.childElements {
            for element in allElements {
                let xmlItem = XML.Accessor(element)

                if let fileName = xmlItem[SignedFileResponseKeys.filename.rawValue].text,
                    let base64String  = xmlItem[SignedFileResponseKeys.file.rawValue].text,
                    let content =  Data(base64Encoded: base64String, options: Data.Base64DecodingOptions.ignoreUnknownCharacters) {
                    let file = File.init(name: fileName, content: content)
                    result.append(file)
                }
            }
        }
        return result
    }
}
