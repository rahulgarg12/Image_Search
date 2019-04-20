//
//  ImageModelViewModel.swift
//  ImageSearch
//
//  Created by Rahul Garg on 20/04/19.
//  Copyright © 2019 Rahul Garg. All rights reserved.
//

import Foundation

struct ImageModelViewModel {
    
    var imageModel: ImageModel?
    
    
    //MARK: Properties
    var imageUrl: URL? {
        var _imageUrl: String?
        
        if let link = imageModel?.link,
            !link.isEmpty {
            _imageUrl = link
        } else if let thumbnail = imageModel?.thumbnailModel?.thumbnailLink,
            !thumbnail.isEmpty {
            _imageUrl = thumbnail
        }
        
        if let urlString = _imageUrl,
            let url = URL(string: urlString) {
            return url
        }
        
        return nil
    }
    
    
    //MARK: Initialisers
    init(model: ImageModel?) {
        imageModel = model
    }
    
}
