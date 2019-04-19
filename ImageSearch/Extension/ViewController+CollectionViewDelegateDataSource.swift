//
//  ViewController+CollectionViewDelegateDataSource.swift
//  ImageSearch
//
//  Created by Rahul Garg on 18/04/19.
//  Copyright © 2019 Rahul Garg. All rights reserved.
//

import Foundation
import UIKit

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.imageItems.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellReuseIdentifiers().imageCell,
                                                      for: indexPath) as! ImageCollectionViewCell
        
        guard let itemCount = viewModel?.imageItems.count,
            itemCount > indexPath.item
            else { return cell }
        
        viewModel?.imageModel = viewModel?.imageItems[indexPath.item]
        cell.configureWith(viewModel: viewModel)
        
        if itemCount > 0,
            indexPath.item == (itemCount - 1),
            viewModel?.isSearchApiInProgress == false {
            
            loadMoreImagesFor(searchText: nil)
        }
        
        return cell
    }
    
}
