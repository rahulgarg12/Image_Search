//
//  ImageModel.swift
//  ImageSearch
//
//  Created by Rahul Garg on 18/04/19.
//  Copyright © 2019 Rahul Garg. All rights reserved.
//

import Foundation
import RealmSwift


class ImageModel: Object {
    
    @objc dynamic var kind: String?
    @objc dynamic var title: String?
    @objc dynamic var link: String?
    @objc dynamic var displayLink: String?
    @objc dynamic var thumbnailModel: ThumbnailModel?
    
    @objc dynamic var searchText: String?
    
    let timestamp = RealmOptional<Double>()
    

    convenience init(object: [String:Any]?, searchText: String?) {
        self.init()
        
        kind = object?[JSONKeyName().kind] as? String
        title = object?[JSONKeyName().title] as? String
        link = object?[JSONKeyName().link] as? String
        displayLink = object?[JSONKeyName().displayLink] as? String
        thumbnailModel = ThumbnailModel(object: object?[JSONKeyName().image] as? [String:Any])
        
        self.searchText = searchText
        
        timestamp.value = Date().timeIntervalSince1970
    }
}


