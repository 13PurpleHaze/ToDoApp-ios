//
//  TasksListService.swift
//  ToDoApp
//
//  Created by Никита Новицкий on 29.07.2025.
//

import CoreData

class TasksListService: TasksListServiceProtocol {
    let context: NSManagedObjectContext
    let coreDataManager: CoreDataManger
    
    required init(coreDataManager: CoreDataManger = CoreDataManger.shared) {
        context = coreDataManager.mainContext
        self.coreDataManager = coreDataManager
    }
    
    func saveTaskList(_ list: TasksListModel) {
        _ = list.mapToEntityInContext(context)
        coreDataManager.saveContext()
    }
    
    func fetchTaskLists() -> [TasksListModel] {
        var lists: [TasksListModel] = []
        do {
            let fetchRequest: NSFetchRequest<TasksList> = TasksList.fetchRequest()
            let value = try context.fetch(fetchRequest)
            lists = value.map { TasksListModel.mapFromEntity($0) }
            lists = lists.sorted(by: { $0.createdAt.compare($1.createdAt) == .orderedDescending  })
        } catch {
            debugPrint("CoreData error")
        }
        return lists
    }
    
    func fetchTaskListWithId(_ id: String) -> TasksListModel? {
        do {
            let fetchRequest: NSFetchRequest<TasksList> = TasksList.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id)
            let value = try context.fetch(fetchRequest)
            guard let first = value.first else { return nil }
            return TasksListModel.mapFromEntity(first)
        } catch {
            debugPrint("CoreData error")
            return nil
        }
    }
    
    func deleteList(_ list: TasksListModel) {
        do {
            let fetchRequest: NSFetchRequest<TasksList> = TasksList.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", list.id)
            let value = try context.fetch(fetchRequest)
            guard let first = value.first else { return }
            context.delete(first)
            coreDataManager.saveContext()
        } catch {
            debugPrint("CoreData error")
        }
    }
}
