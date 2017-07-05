//
//  Signature.swift
//  YouSign
//
//  Created by Mahmoud Ben Messaoud on 05/06/2017.
//  Copyright © 2017 Mahmoud Ben Messaoud. All rights reserved.
//

import Foundation

@objc public class Token : NSObject{
    public var token: String = kEmptyString
    public var mail: String?
    public var phone: String?
}

@objc public class FileInfo : NSObject{
    public var id: String = kEmptyString
    public var fileName: String = kEmptyString
    public var sha1: String = kEmptyString
}

@objc public class Signature: NSObject {

    public var id: String
    var files = [FileInfo]()
    var tokens = [Token]()
    init(idDemand: String) {
        self.id = idDemand
    }

    public func addFileInfo(fileInfo: FileInfo){
        files.append(fileInfo)
    }

    public func addToken(token: Token){
        tokens.append(token)
    }

    public func getToken(forSigner signer: Signer) -> Token {
        let token = tokens.filter { (item: Token) -> Bool in
            return signer.mail == item.mail && signer.phone == item.phone
        }

        return token.first ?? Token()
    }
}
