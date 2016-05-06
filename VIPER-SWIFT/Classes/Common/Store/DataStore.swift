import Foundation

protocol DataStore {
    func fetchEntriesWithPredicate(predicate: NSPredicate, sortDescriptors: [AnyObject], completionBlock: (([ManagedTodoItem]) -> Void)!)
    func newTodoItem() -> ManagedTodoItem 
    func save()
}
