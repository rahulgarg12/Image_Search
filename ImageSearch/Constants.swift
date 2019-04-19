//
//  Constants.swift
//  ImageSearch
//
//  Created by Rahul Garg on 17/04/19.
//  Copyright © 2019 Rahul Garg. All rights reserved.
//

import Foundation

struct ProjectKeys {
    let googleCX = "000669803540663600203:gpg5ctf5wzw"
    let googleKey = "AIzaSyAG9htb03kM3OAdwAUWQwwibt5aob22tGs"
}

struct JSONKeyName {
    //Google
    let num = "num"
    let query = "q"
    let start = "start"
    let imgSize = "imgSize"
    let searchType = "searchType"
    let filetype = "filetype"
    let googleKey = "key"
    let googleCx = "cx"
    
    //Google Value
    let items = "items"
    let imageSize = "medium"
    let image = "image"
    let imageType = "jpg"
    let itemsCount = "10"
    
    //Image Model
    let kind = "kind"
    let title = "title"
    let link = "link"
    let displayLink = "displayLink"
    
    //Thumbnail Model
    let thumbnailHeight = "thumbnailHeight"
    let thumbnailWidth = "thumbnailWidth"
    let thumbnailLink = "thumbnailLink"
}

struct ViewControllerIdentifiers {
    let imageGridVC = "ViewController"
}

struct CollectionViewCellReuseIdentifiers {
    let imageCell = "ImageCollectionViewCell"
}
