//
//  EntityModelMapProtocol.swift
//  ToDoApp
//
//  Created by Никита Новицкий on 29.07.2025.
//

import CoreData

protocol EntityModelMapProtocol {
    associatedtype EntityType: NSManagedObject
    
    func mapToEntityInContext(_ context: NSManagedObjectContext) -> EntityType
    static func mapFromEntity(_ entity: EntityType) -> Self
}
