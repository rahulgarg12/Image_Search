//
//  ImageCollectionViewCell.swift
//  ImageSearch
//
//  Created by Rahul Garg on 18/04/19.
//  Copyright © 2019 Rahul Garg. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher


class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var flickrImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }   
}


//MARK:- Outside Accessible Helpers
extension ImageCollectionViewCell {
    
    func configureWith(model: ImageModelViewModel?) {
        flickrImageView.kf.setImage(with: model?.imageUrl)
    }
}
