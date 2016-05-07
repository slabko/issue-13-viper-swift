import Foundation

protocol DataStore {
    func fetchEntriesWithPredicate(predicate: ((TodoItem) -> Bool),
                                   completionBlock: (([TodoItem]) -> Void))
    func addTodoItem(item: TodoItem) 
}
