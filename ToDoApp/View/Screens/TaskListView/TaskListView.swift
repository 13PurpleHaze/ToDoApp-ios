//
//  TaskListView.swift
//  ToDoApp
//
//  Created by Никита Новицкий on 29.07.2025.
//

import UIKit

class TaskListView: UIView {
    weak var delegate: TaskListViewDelegate?
    
    private let tableView = UITableView()
    let emptyView = EmptyStateView(title: "Has no tasks")
    private let addListButton = MainButton(title: "Add task", color: .systemMint)
    private var tasks: [TaskModel] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .systemBackground
        
        configureTableView()
        configureAddListButton()
        configureEmptyState()
    }
    
    private func configureTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.reuseIdentifier)
        tableView.separatorColor = .clear
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    private func configureAddListButton() {
        addSubview(addListButton)
        addListButton.addTarget(self, action: #selector(addList), for: .touchUpInside)
        NSLayoutConstraint.activate([
            addListButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            addListButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            addListButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    private func configureEmptyState() {
        addSubview(emptyView)
        
        NSLayoutConstraint.activate([
            emptyView.centerYAnchor.constraint(equalTo: centerYAnchor),
            emptyView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: 20),
            emptyView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: -20),
        ])
    }
    
    @objc func addList() {
        delegate?.addListAction()
    }
    
    func setTasks(_ tasks: [TaskModel]) {
        emptyView.isHidden = !tasks.isEmpty
        self.tasks = tasks
        tableView.reloadData()
    }
}

extension TaskListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.reuseIdentifier, for: indexPath) as? TaskCell else {
            return UITableViewCell(style: .default, reuseIdentifier: "UITableViewCell")
        }
        cell.setTask(tasks[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let task = tasks[indexPath.row]
        tasks.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        delegate?.deleteTask(task)
    }
}

extension TaskListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
