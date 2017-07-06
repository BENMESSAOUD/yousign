//
//  YouSignKeysDescription.swift
//  YouSign
//
//  Created by Mahmoud Ben Messaoud on 01/06/2017.
//  Copyright © 2017 Mahmoud Ben Messaoud. All rights reserved.
//

import Foundation
enum XMLRequestKeys: String {
    case envelope = "soapenv:Envelope"
    case header = "soapenv:Header"
    case body = "soapenv:Body"
    case connect = "yous:connect"
    case initCosign = "yous:initCosign"
    case confirmCosign = "yous:confirmCosign"
    case signedFile = "yous:getCosignedFilesFromDemand"
}

enum ApiScheme: String {
    case authentification = "AuthenticationWS/AuthenticationWS"
    case signature = "CosignWS/CosignWS"
}

enum HeaderKeys: String {
    case username = "username"
    case password = "password"
    case apikey = "apikey"
}

enum XMLResponseKeys: String {
    case envelope = "S:Envelope"
    case body = "S:Body"
    case _return = "return"
    case connect = "ns2:connectResponse"
    case initSign = "ns2:initCosignResponse"
    case confirmSign = "ns2:confirmCosignResponse"
    case signedFile = "ns2:getCosignedFilesFromDemandResponse"
}

enum StatusCode: Int {
    case ok = 200
    case badRequest = 404
    case serverError = 501
}

enum FileKeys: String {
    case name = "lstCosignedFile"
    case filename = "name"
    case content = "content"
    case pdfPassword = "pdfPassword"
}

enum VisibleOptionsKeys: String {
    case name = "visibleOptions"
    case page = "visibleSignaturePage"
    case isVisible = "isVisibleSignature"
    case position = "visibleRectangleSignature"
    case mail = "mail"
}

enum SignerKeys: String{
    case name = "lstCosignerInfos"
    case firstname = "firstName"
    case lastname = "lastName"
    case mail = "mail"
    case phone = "phone"
}

enum SignatureResponseKeys: String {
    case idDemand = "idDemand"
    case fileInfos = "fileInfos"
    case idFile = "idFile"
    case filename = "fileName"
    case sha1 = "sha1"
    case tokens = "tokens"
    case token = "token"
    case mail = "mail"
    case phone = "phone"
}

enum SignatureRequestKeys: String {
    case intiMailSubject = "initMailSubject"
    case intiMail = "initMail"
    case endMailSubject = "endMailSubject"
    case endMail = "endMail"
    case message = "message"
    case mode = "mode"
}

enum ConfirmationRequestKeys: String {
    case token = "token"
    case otp = "strAuthParam"
    case image = "signatureImage"
}

enum SignedFileResponseKeys: String {
    case file = "file"
    case filename = "fileName"
}


enum ConnectorError: Error{
    case url
    case xml
    case server

    var code: Int {
        switch self {
        case .url:
            return 0
        case .xml:
            return 1
        case .server:
            return 2
        }
    }

    var message: String {
        switch self {
        case .url:
            return "Error: cannot create URL"
        case .xml:
            return "Wrong XML format."
        case .server:
            return "An Error has been occured. Please try later."
        }
    }
}


