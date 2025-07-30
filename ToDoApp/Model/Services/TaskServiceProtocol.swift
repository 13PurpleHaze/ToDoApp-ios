//
//  TaskServiceProtocol.swift
//  ToDoApp
//
//  Created by Никита Новицкий on 29.07.2025.
//

import CoreData

protocol TaskServiceProtocol: AnyObject {
    init(coreDataManager: CoreDataManger)
    func saveTask(_ task: TaskModel, in taskList: TasksListModel)
    func fetchTasksForList(_ taskList: TasksListModel) -> [TaskModel]
    func updateTask(_ task: TaskModel)
    func deleteTask(_ task: TaskModel)
}
