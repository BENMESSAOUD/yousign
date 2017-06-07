//
//  Communicator.swift
//  YouSign
//
//  Created by Mahmoud Ben Messaoud on 01/06/2017.
//  Copyright © 2017 Mahmoud Ben Messaoud. All rights reserved.
//

import Foundation

class Connector {

    func sendSoapRequest(url: URL, xml: String, soapAction: String, completion: @escaping (Data?, Int , Error?) -> Void) {
        let request = NSMutableURLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 40.0)
        request.httpMethod = "POST"
        request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue("\(xml.characters.count)", forHTTPHeaderField: "Content-Length")
//        request.addValue(soapAction, forHTTPHeaderField: "SOAPAction")
        request.httpBody = xml.data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { (data, urlResponse, error) in
            let httpResponse = urlResponse as? HTTPURLResponse
            completion(data, httpResponse?.statusCode ?? 404, error)
        }
        task.resume()
    }

}
