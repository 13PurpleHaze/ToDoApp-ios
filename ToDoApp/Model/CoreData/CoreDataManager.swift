//
//  CoreDataManager.swift
//  ToDoApp
//
//  Created by Никита Новицкий on 29.07.2025.
//

import Foundation
import CoreData

class CoreDataManger {
    static let shared = CoreDataManger()
    
    init() {}
    
    // Подгрузка контейнера при первом обращении
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ToDoApp")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    lazy var mainContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    func saveContext() {
        saveContext(mainContext)
    }
    
    func saveContext(_ context: NSManagedObjectContext) {
        if context.parent == mainContext {
            saveDirivedContext(context)
            return
        }
        context.perform {
            do {
                try context.save()
            } catch {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func saveDirivedContext(_ context: NSManagedObjectContext) {
        context.perform { [self] in
            do {
                try context.save()
            } catch {
                fatalError("Error: \(error.localizedDescription)")
            }
            
            saveContext(mainContext)
        }
    }
}
