//
//  AddTaskViewController.swift
//  ToDoApp
//
//  Created by Никита Новицкий on 29.07.2025.
//

import UIKit

class AddTaskViewController: UIViewController {
    private let taskService: TaskServiceProtocol
    private let addTaskView = AddTaskView()
    private let list: TasksListModel
    
    init(taskService: TaskServiceProtocol, list: TasksListModel) {
        self.taskService = taskService
        self.list = list
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        addTaskView.delegate = self
        view = addTaskView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Task"
    }

}

extension AddTaskViewController: AddTaskViewDelegate {
    func addTask(_ task: TaskModel) {
        taskService.saveTask(task, in: list)
        navigationController?.dismiss(animated: true)
    }
}
