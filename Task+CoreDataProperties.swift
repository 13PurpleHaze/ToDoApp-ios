//
//  Task+CoreDataProperties.swift
//  ToDoApp
//
//  Created by Никита Новицкий on 29.07.2025.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var createdAt: Date
    @NSManaged public var done: Bool
    @NSManaged public var title: String
    @NSManaged public var icon: String
    @NSManaged public var id: String
    @NSManaged public var list: TasksList?

}

extension Task : Identifiable {

}
