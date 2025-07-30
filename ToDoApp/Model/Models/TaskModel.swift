//
//  TaskModel.swift
//  ToDoApp
//
//  Created by Никита Новицкий on 29.07.2025.
//

import Foundation
import CoreData

struct TaskModel: EntityModelMapProtocol {
    var id: String
    var title: String
    var icon: String
    var done: Bool
    var createdAt: Date
    
    func mapToEntityInContext(_ context: NSManagedObjectContext) -> Task {
        let entity = Task(context: context)
        entity.id = id
        entity.title = title
        entity.icon = icon
        entity.done = done
        entity.createdAt = createdAt
        return entity
    }
    
    static func mapFromEntity(_ entity: Task) -> Self {
        TaskModel(id: entity.id, title: entity.title, icon: entity.icon, done: entity.done, createdAt: entity.createdAt)
    }
}
