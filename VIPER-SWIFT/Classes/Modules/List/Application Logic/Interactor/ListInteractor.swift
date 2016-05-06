//
//  ListInteractor.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/5/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation

class ListInteractor : NSObject, ListInteractorInput {
    var output : ListInteractorOutput?
    
    let clock : Clock
    var dataStore : DataStore
    
    init(dataStore: DataStore, clock: Clock) {
        self.dataStore = dataStore
        self.clock = clock
    }
    
    func findUpcomingItems() {
        let today = clock.today()
        let endOfNextWeek = NSCalendar.currentCalendar().dateForEndOfFollowingWeekWithDate(today)
        
        todoItemsBetweenStartDate(today,
            endDate: endOfNextWeek,
            completion: { todoItems in
                let upcomingItems = self.upcomingItemsFromToDoItems(todoItems)
                self.output?.foundUpcomingItems(upcomingItems)
        })
    }
    
    func upcomingItemsFromToDoItems(todoItems: [TodoItem]) -> [UpcomingItem] {
        let calendar = NSCalendar.autoupdatingCurrentCalendar()
        
        var upcomingItems : [UpcomingItem] = []
        
        for todoItem in todoItems {
            let dateRelation = calendar.nearTermRelationForDate(todoItem.dueDate, relativeToToday: clock.today())
            let upcomingItem = UpcomingItem(title: todoItem.name, dueDate: todoItem.dueDate, dateRelation: dateRelation)
            upcomingItems.insert(upcomingItem, atIndex: upcomingItems.endIndex)
        }
        
        return upcomingItems
    }

    func todoItemsBetweenStartDate(startDate: NSDate, endDate: NSDate, completion: (([TodoItem]) -> Void)!) {
        let calendar = NSCalendar.autoupdatingCurrentCalendar()
        let beginning = calendar.dateForBeginningOfDay(startDate)
        let end = calendar.dateForEndOfDay(endDate)
        
        let predicate = NSPredicate(format: "(date >= %@) AND (date <= %@)", beginning, end)
        let sortDescriptors = []
        
        dataStore.fetchEntriesWithPredicate(predicate,
            sortDescriptors: sortDescriptors as [AnyObject],
            completionBlock: { entries in
                let todoItems = self.todoItemsFromDataStoreEntries(entries)
                completion(todoItems)
        })
    }
    
    func todoItemsFromDataStoreEntries(entries: [ManagedTodoItem]) -> [TodoItem] {
        var todoItems : [TodoItem] = []
        
        for managedTodoItem in entries {
            let todoItem = TodoItem(dueDate: managedTodoItem.date, name: managedTodoItem.name as String)
            todoItems.append(todoItem)
        }
        
        return todoItems
    }
}
