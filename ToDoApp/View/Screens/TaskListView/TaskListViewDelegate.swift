//
//  TaskListViewDelegate.swift
//  ToDoApp
//
//  Created by Никита Новицкий on 29.07.2025.
//

protocol TaskListViewDelegate: AnyObject {
    func addListAction()
    func updateTask(_ task: TaskModel)
    func deleteTask(_ task: TaskModel)
}
