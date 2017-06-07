//
//  SignatureRequest.swift
//  YouSign
//
//  Created by Mahmoud Ben Messaoud on 05/06/2017.
//  Copyright © 2017 Mahmoud Ben Messaoud. All rights reserved.
//

import Foundation
import SwiftyXMLParser

public class SignatureRequest: Action, Requestable {

    public typealias ReturnType = Signature

    private var files = [File]()
    private var signers = [Signer]()
    public var requestMailSubject: String?
    public var requestMail: String?
    public var confirmationMailSubject: String?
    public var confirmationMail: String?
    public var message: String?

    public func addFile(_ file: File){
        files.append(file)
    }

    public func removeAllFiles() {
        files.removeAll()
    }

    public func addSigner(_ signer: Signer){
        signers.append(signer)
    }

    public func removeAllSigners() {
        signers.removeAll()
    }
    override public var name: String{
        return XMLRequestKeys.initCosign.rawValue
    }

    override public var childs: [Node]?{
        var result = [Node]()
        for file in files {
            result.append(file)
        }
        for signer in signers {
            result.append(signer)
        }
        return result
    }

    override public var values: [String : String]?{
        if let message = message {
            return [SignatureRequestKeys.message.rawValue : message]
        }
        if let initSubject = requestMailSubject,
            let initMail = requestMail,
            let endSubject = confirmationMailSubject,
            let endMail = confirmationMail{
            return [
                SignatureRequestKeys.intiMailSubject.rawValue : initSubject,
                SignatureRequestKeys.intiMail.rawValue : initMail,
                SignatureRequestKeys.endMailSubject.rawValue : endSubject,
                SignatureRequestKeys.endMail.rawValue : endMail
            ]
        }

        return nil
    }

    override public var apiScheme: String {
        return ApiScheme.signature.rawValue
    }

    override public var soapAction: String {
        return kEmptyString
    }

    public func send(onSuccess: @escaping (Signature) -> Void, onFail: @escaping Requestable.OnFail) {
        sendRequest { (data, statusCode, err) in
            if let error = err {
                onFail(error, statusCode)
            }
            else if let data = data, statusCode == StatusCode.ok.rawValue {
                let xml = XML.parse(data)
                let result = self.getResult(actionName: .initSign, parser: xml)
                if let signature = self.getSignature(parser: result) {
                    onSuccess(signature)
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

    private func getSignature(parser: XML.Accessor) -> Signature? {
        guard let id = parser[SignatureResponseKeys.idDemand.rawValue].text else {
            return nil
        }

        let result = Signature(idDemand: id)

        if let allElements = parser.element?.childElements {

            for element in allElements {
                if let elemntType = SignatureResponseKeys(rawValue: element.name){
                    switch elemntType {
                    case .fileInfos:
                        let xmlItem = XML.Accessor(element)
                        let fileInfo: FileInfo = (id: xmlItem[SignatureResponseKeys.idFile.rawValue].text ?? kEmptyString,
                                                  fileName :xmlItem[SignatureResponseKeys.filename.rawValue].text ?? kEmptyString,
                                                  sha1 : xmlItem[SignatureResponseKeys.sha1.rawValue].text ?? kEmptyString)
                        result.addFileInfo(fileInfo: fileInfo)
                    case .tokens:
                        let xmlItem = XML.Accessor(element)
                        let token: Token = (token: xmlItem[SignatureResponseKeys.idFile.rawValue].text ?? kEmptyString,
                                                  mail :xmlItem[SignatureResponseKeys.filename.rawValue].text,
                                                  phone : xmlItem[SignatureResponseKeys.sha1.rawValue].text)
                        result.addToken(token: token)
                        break
                    default:
                        break
                    }
                }
            }
        }

        return result
    }
    
}
