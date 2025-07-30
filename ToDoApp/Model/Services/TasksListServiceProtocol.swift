//
//  TasksListServiceProtocol.swift
//  ToDoApp
//
//  Created by Никита Новицкий on 29.07.2025.
//

protocol TasksListServiceProtocol: AnyObject {
    init(coreDataManager: CoreDataManger)
    func saveTaskList(_ list: TasksListModel)
    func fetchTaskLists() -> [TasksListModel]
    func fetchTaskListWithId(_ id: String) -> TasksListModel?
    func deleteList(_ list: TasksListModel)
}
