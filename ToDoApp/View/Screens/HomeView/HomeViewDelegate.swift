//
//  HomeViewDelegate.swift
//  ToDoApp
//
//  Created by Никита Новицкий on 29.07.2025.
//

protocol HomeViewDelegate: AnyObject {
    func addListAction()
    func selectedList(_ list: TasksListModel)
    func deleteList(_ list: TasksListModel)
}
