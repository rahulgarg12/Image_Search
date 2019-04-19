//
//  ThumbnailModel.swift
//  ImageSearch
//
//  Created by Rahul Garg on 19/04/19.
//  Copyright © 2019 Rahul Garg. All rights reserved.
//

import Foundation
import RealmSwift


class ThumbnailModel: Object {
    
    @objc dynamic var thumbnailHeight: String?
    @objc dynamic var thumbnailWidth: String?
    @objc dynamic var thumbnailLink: String?
    
    
    convenience init(object: [String:Any]?) {
        self.init()
        
        thumbnailHeight = object?[JSONKeyName().thumbnailHeight] as? String
        thumbnailWidth = object?[JSONKeyName().thumbnailWidth] as? String
        thumbnailLink = object?[JSONKeyName().thumbnailLink] as? String
    }
}
