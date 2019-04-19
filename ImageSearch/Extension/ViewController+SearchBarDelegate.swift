//
//  ViewController+SearchBarDelegate.swift
//  ImageSearch
//
//  Created by Rahul Garg on 18/04/19.
//  Copyright © 2019 Rahul Garg. All rights reserved.
//

import Foundation
import UIKit

extension ViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        
        searchBar.text = nil
        viewModel?.emptyListItems()
        reloadCollectionView()
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        
        guard let text = searchBar.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines),
            !text.isEmpty
            else { return }
        
        viewModel = ViewModel()
        
        if let cachedItems = viewModel?.getCachedDataFor(searchText: text),
            !cachedItems.isEmpty {
            showCachedDataFoundAlert(searchText: text, cachedItems: cachedItems)
        } else {
            loadMoreImagesFor(searchText: text)
        }
    }
    
}
