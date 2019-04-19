//
//  NetworkStruct.swift
//  ImageSearch
//
//  Created by Rahul Garg on 17/04/19.
//  Copyright © 2019 Rahul Garg. All rights reserved.
//

import Foundation

struct HTTPHeader {
    let field: String
    let value: String
}

struct NetworkResponse<Body> {
    let statusCode: Int
    let body: Body
}


struct APIClient {
    
    typealias APIClientCompletion = (APIResult<Data?>) -> Void
    
    private let session = URLSession.shared
    private let baseURL = URL(string: "https://jsonplaceholder.typicode.com")!
    
    func perform(_ request: NetworkRequest, _ completion: @escaping APIClientCompletion) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = baseURL.scheme
        urlComponents.host = baseURL.host
        urlComponents.path = baseURL.path
        urlComponents.queryItems = request.queryItems
        
        guard let url = urlComponents.url?.appendingPathComponent(request.path) else {
            completion(.failure(.invalidURL)); return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        
        request.headers?.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.field) }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed)); return
            }
            
            completion(.success(NetworkResponse<Data?>(statusCode: httpResponse.statusCode, body: data)))
        }
        
        task.resume()
    }
}
