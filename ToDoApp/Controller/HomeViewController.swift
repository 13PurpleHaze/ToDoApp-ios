//
//  HomeViewController.swift
//  ToDoApp
//
//  Created by Никита Новицкий on 29.07.2025.
//

import UIKit

class HomeViewController: UIViewController {
    private let homeView = HomeView()
    private let taskService: TaskServiceProtocol
    private let tasksListService: TasksListServiceProtocol
    
    init(taskService: TaskServiceProtocol, tasksListService: TasksListServiceProtocol) {
        self.taskService = taskService
        self.tasksListService = tasksListService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        homeView.delegate = self
        view = homeView
        fetchTasksList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        NotificationCenter.default.addObserver(self, selector: #selector(contextObjectsDidChange), name: NSNotification.Name.NSManagedObjectContextObjectsDidChange, object: CoreDataManger.shared.mainContext)
    }
}

extension HomeViewController {
    private func fetchTasksList() {
        let lists = tasksListService.fetchTaskLists()
        homeView.setTasksLists(lists)
    }
    
    @objc func contextObjectsDidChange() {
        fetchTasksList()
    }
}

extension HomeViewController: HomeViewDelegate {
    func addListAction() {
        let addListVC = AddListViewController(tasksListService: tasksListService)
        navigationController?.pushViewController(addListVC, animated: true)
    }
    
    func selectedList(_ list: TasksListModel) {
        let taskListVC = TaskListViewController(taskService: taskService, tasksListService: tasksListService, list: list)
        navigationController?.pushViewController(taskListVC, animated: true)
    }
    
    func deleteList(_ list: TasksListModel) {
        tasksListService.deleteList(list)
    }
}
