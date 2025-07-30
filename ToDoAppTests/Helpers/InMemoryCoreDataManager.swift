//
//  InMemoryCoreDataManager.swift
//  ToDoApp
//
//  Created by Никита Новицкий on 30.07.2025.
//

import Foundation
import CoreData

@testable import ToDoApp

class InMemoryCoreDataManager: CoreDataManger {
    
    override init() {
        super.init()
        
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        
        let container = NSPersistentContainer(name: "ToDoList")
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        persistentContainer = container
    }
}
