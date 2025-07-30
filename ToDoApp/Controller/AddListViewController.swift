//
//  AddListViewController.swift
//  ToDoApp
//
//  Created by Никита Новицкий on 29.07.2025.
//

import UIKit

class AddListViewController: UIViewController {
    private let tasksListService: TasksListServiceProtocol
    private let addListView = AddListView()
    
    init(tasksListService: TasksListServiceProtocol) {
        self.tasksListService = tasksListService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        addListView.delegate = self
        view = addListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add list"
    }
}

extension AddListViewController: AddListViewDelegate {
    func addList(_ list: TasksListModel) {
        tasksListService.saveTaskList(list)
        navigationController?.popViewController(animated: true)
    }
}
