//
//  ViewModel.swift
//  ImageSearch
//
//  Created by Rahul Garg on 18/04/19.
//  Copyright © 2019 Rahul Garg. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift


class ViewModel {
    
    var imageModel: ImageModel?
    
    var imageItems = [ImageModel]()
    
    var page = 1
    var searchString: String?
    
    var isSearchApiInProgress = false
    
    
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
    
    
    //MARK: Helper Methods
    func fetchImagesFor(searchText: String?, completion: @escaping (_ isSuccess: Bool) -> ()) {
        
        var queryString: String?
        if let _searchText = searchText {
            searchString = _searchText
            queryString = _searchText
        } else if let _searchText = searchString {
            queryString = _searchText
        }
        
        guard let _queryString = queryString else { return }
        let _page = ((page-1) * (Int(JSONKeyName().itemsCount) ?? 10)) + 1
        
        isSearchApiInProgress = true
        
        
        let url = NetworkAPIList().imageSearchApi
            + "?\(JSONKeyName().num)=\(JSONKeyName().itemsCount)"
            + "&\(JSONKeyName().query)=\(_queryString)"
            + "&\(JSONKeyName().start)=\(_page)"
            + "&\(JSONKeyName().imgSize)=\(JSONKeyName().imageSize)"
            + "&\(JSONKeyName().searchType)=\(JSONKeyName().image)"
            + "&\(JSONKeyName().filetype)=\(JSONKeyName().imageType)"
            + "&\(JSONKeyName().googleKey)=\(ProjectKeys().googleKey)"
            + "&\(JSONKeyName().googleCx)=\(ProjectKeys().googleCX)"
        
        let request = NetworkRequest(method: .get,
                                     url: url)
        initiateNetwork(request: request) { [weak self] (success, fetchedItems) in
            
            DispatchQueue.main.async {
                self?.isSearchApiInProgress = false
                
                if success {
                    fetchedItems?.forEach {
                        let model = ImageModel(object: $0,
                                               searchText: queryString)
                        self?.imageItems.append(model)
                        
                        DatabaseHandler.shared.addToDatabase(model: model)
                    }
                }
            }
            
            completion(success)
        }
    }
    
    func addToList(items: Results<ImageModel>) {
        items.forEach { self.imageItems.append($0) }
    }
    
    func emptyListItems() {
        imageItems.removeAll()
    }
}


//MARK:- Database Helpers
extension ViewModel {
    
    func getCachedDataFor(searchText: String) -> Results<ImageModel>? {
        return DatabaseHandler.shared.fetchDataFromDatabaseForSearchText(searchText)
    }
    
    func removeCachedDataFor(searchText: String) {
        DatabaseHandler.shared.removeDataFromDatabaseForSearchText(searchText)
    }
}


//MARK:- Private Helpers
extension ViewModel {
    
    private func initiateNetwork(request: NetworkRequest, completion: @escaping (_ isSuccess: Bool, _ fetchedItems: [[String:Any]]?) -> ()) {
        
        APIClient().perform(request) { (result) in
            
            switch result {
            case .success(let response):
                do {
                    guard let body = response.body,
                        let dict = try JSONSerialization.jsonObject(with: body,
                                                                    options: []) as? NSDictionary,
                        let items = dict[JSONKeyName().items] as? [[String:Any]]
                        else {
                            completion(false, nil)
                            return
                    }
                    
                    completion(true, items)
                    
                } catch let error {
                    print("Failed to decode response with error \(error)")
                    completion(false, nil)
                }
                
            case .failure:
                print("Error performing network request")
                completion(false, nil)
            }
        }
    }
}
