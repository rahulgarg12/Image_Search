//
//  DatabaseHandler.swift
//  ImageSearch
//
//  Created by Rahul Garg on 18/04/19.
//  Copyright © 2019 Rahul Garg. All rights reserved.
//

import Foundation
import RealmSwift

class DatabaseHandler {
    
    static let shared = DatabaseHandler()
    
    private init() { }
    
    
    func addToDatabase(model: ImageModel?) {
        
        guard let model = model else { return }
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(model)
        }
    }
    
    
    func fetchDataFromDatabaseForSearchText(_ searchText: String) -> Results<ImageModel>? {
        
        let allObjects = fetchAllObjects()
        
        if !allObjects.isEmpty {
            let filteredObjects = allObjects.filter("searchText == '\(searchText)'")
            
            if !filteredObjects.isEmpty {
                return filteredObjects.sorted(byKeyPath: "timestamp")
            }
        }

        return nil
    }
    
    
    func removeDataFromDatabaseForSearchText(_ searchText: String) {
        let filteredObjects = fetchAllObjects().filter("searchText == '\(searchText)'")
        
        let realm = try! Realm()
        try! realm.write {
            realm.delete(filteredObjects)
        }
    }
    
}



//MARK:- Private Helpers
extension DatabaseHandler {
    
    private func fetchAllObjects() -> Results<ImageModel> {
        let realm = try! Realm()
        return realm.objects(ImageModel.self)
    }
}
