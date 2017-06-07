//
//  String+Extension.swift
//  YouSign
//
//  Created by Mahmoud Ben Messaoud on 29/05/2017.
//  Copyright © 2017 Mahmoud Ben Messaoud. All rights reserved.
//

import Foundation
import CryptoSwift

extension String {

    var sha1: String {
        return self.sha1()
    }
}
