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
    let path: String
    var queryItems: [URLQueryItem]?
    var headers: [HTTPHeader]?
    var body: Data?
    
    init(method: HTTPMethod, path: String) {
        self.method = method
        self.path = path
    }
    
    init<Body: Encodable>(method: HTTPMethod, path: String, body: Body) throws {
        self.method = method
        self.path = path
        self.body = try JSONEncoder().encode(body)
    }
}
