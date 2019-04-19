//
//  NetworkResponse+Extension.swift
//  ImageSearch
//
//  Created by Rahul Garg on 17/04/19.
//  Copyright © 2019 Rahul Garg. All rights reserved.
//

import Foundation

extension NetworkResponse where Body == Data? {
    
    func decode<BodyType: Decodable>(to type: BodyType.Type) throws -> NetworkResponse<BodyType> {
        
        guard let data = body else {
            throw APIError.decodingFailure
        }
        
        let decodedJSON = try JSONDecoder().decode(BodyType.self, from: data)
        return NetworkResponse<BodyType>(statusCode: self.statusCode,
                                         body: decodedJSON)
    }
}
