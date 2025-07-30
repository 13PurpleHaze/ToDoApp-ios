//
//  TaskListViewController.swift
//  ToDoApp
//
//  Created by Никита Новицкий on 29.07.2025.
//

import UIKit
import CoreData

class TaskListViewController: UIViewController {
    private let taskService: TaskServiceProtocol
    private let tasksListService: TasksListServiceProtocol
    private let list: TasksListModel
    private let taskListView = TaskListView()
    
    init(taskService: TaskServiceProtocol, tasksListService: TasksListServiceProtocol, list: TasksListModel) {
        self.taskService = taskService
        self.tasksListService = tasksListService
        self.list = list
        super.init(nibName: nil, bundle: nil)
        self.title = list.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(contextObjectsDidChange),
            name: NSNotification.Name.NSManagedObjectContextObjectsDidChange,
            object: CoreDataManger.shared.mainContext)
    }
    
    override func loadView() {
        taskListView.delegate = self
        view = taskListView
        fetchTasks()
    }
}

extension TaskListViewController {
    private func fetchTasks() {
        let tasks = taskService.fetchTasksForList(list)
        taskListView.setTasks(tasks)
    }
    
    @objc func contextObjectsDidChange() {
        fetchTasks()
    }
}

extension TaskListViewController: TaskListViewDelegate {
    func addListAction() {
        let addTaskVC = AddTaskViewController(taskService: taskService, list: list)
        let navController = UINavigationController(rootViewController: addTaskVC)
        navigationController?.present(navController, animated: true)
    }
    
    func updateTask(_ task: TaskModel) {
        taskService.updateTask(task)
    }
    
    func deleteTask(_ task: TaskModel) {
        taskService.deleteTask(task)
    }
}
