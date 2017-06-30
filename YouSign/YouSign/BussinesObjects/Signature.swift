//
//  Signature.swift
//  YouSign
//
//  Created by Mahmoud Ben Messaoud on 05/06/2017.
//  Copyright © 2017 Mahmoud Ben Messaoud. All rights reserved.
//

import Foundation

public typealias Token = (token:String, mail: String?, phone: String?)
public typealias FileInfo = (id:String, fileName: String, sha1: String)

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

        return token.first ?? (token:kEmptyString, mail: nil, phone: nil)
    }
}
