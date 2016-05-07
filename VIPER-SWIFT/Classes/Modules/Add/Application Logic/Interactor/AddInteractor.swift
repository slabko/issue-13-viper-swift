//
//  AddInteractor.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/4/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation

class AddInteractor : NSObject {
    let dataStore : DataStore
    
    init(dataStore: DataStore) {
        self.dataStore = dataStore
    }

    func saveNewEntryWithName(name: NSString, dueDate: NSDate) {
        let newEntry = TodoItem(dueDate: dueDate, name: name as String)
        dataStore.addTodoItem(newEntry)
    }

}
