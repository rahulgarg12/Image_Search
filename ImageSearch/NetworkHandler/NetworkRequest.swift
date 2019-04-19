//
//  NetworkRequest.swift
//  ImageSearch
//
//  Created by Rahul Garg on 17/04/19.
//  Copyright © 2019 Rahul Garg. All rights reserved.
//

import Foundation

class NetworkRequest {
    
    let method: HTTPMethod
    let url: String
    var queryItems: [URLQueryItem]?
    var headers: [HTTPHeader]?
    var body: Data?
    
    init(method: HTTPMethod, url: String, headers: [HTTPHeader]? = nil, bodyDict: [String:Any]? = nil) {
        self.method = method
        self.url = url
        
        if let headers = headers {
            self.headers = headers
        }
        
        if let bodyDict = bodyDict {
            self.body = try? JSONSerialization.data(withJSONObject: bodyDict)
        }
    }
    
}
