import Foundation

class MemoryDataStore: DataStore {

    private var array: [TodoItem] = [] 

    func fetchEntriesWithPredicate(predicate: ((TodoItem) -> Bool),
                                   completionBlock: (([TodoItem]) -> Void)) {
        let res: [TodoItem] = array.filter(predicate)
        completionBlock(res)
    }

    func addTodoItem(item: TodoItem) {
        self.array.append(item)
    }
}
