//
//  TasksListModel.swift
//  ToDoApp
//
//  Created by Никита Новицкий on 29.07.2025.
//

import Foundation
import CoreData

struct TasksListModel: EntityModelMapProtocol {
    var id: String
    var title: String
    var icon: String
    var tasks: [TaskModel]
    var createdAt: Date
    
    func mapToEntityInContext(_ context: NSManagedObjectContext) -> TasksList {
        let entity = TasksList(context: context)
        entity.id = id
        entity.title = title
        entity.icon = icon
        entity.createdAt = createdAt
        entity.tasks = Set(tasks.map { $0.mapToEntityInContext(context) }) as NSSet
        return entity
    }
    
    static func mapFromEntity(_ entity: TasksList) -> TasksListModel {
        guard let tasks = entity.tasks, let tasks = Array(tasks) as? [Task] else { return TasksListModel(id: entity.id, title: entity.title, icon: entity.icon, tasks: [], createdAt: entity.createdAt) }
        return TasksListModel(id: entity.id, title: entity.title, icon: entity.icon, tasks: tasks.map { TaskModel.mapFromEntity($0) }, createdAt: entity.createdAt)
    }
}
