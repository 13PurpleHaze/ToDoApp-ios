//
//  HomeView.swift
//  ToDoApp
//
//  Created by Никита Новицкий on 29.07.2025.
//

import UIKit

class HomeView: UIView {
    private(set) var tableView = UITableView()
    private(set) var addListButton = MainButton(title: "Add list",color: .systemMint)
    private(set) var lists: [TasksListModel] = []
    private(set) var emptyView = EmptyStateView(title: "Has no tasks lists")
    
    weak var delegate: HomeViewDelegate?
    
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
    }
    
    private func configureTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ListCell.self, forCellReuseIdentifier: ListCell.reuseIdentifier)
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
    
    func setTasksLists(_ lists: [TasksListModel]) {
        emptyView.isHidden = !lists.isEmpty
        self.lists = lists
        tableView.reloadData()
    }
}

extension HomeView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.reuseIdentifier, for: indexPath) as? ListCell else {
            return UITableViewCell(style: .default, reuseIdentifier: "UITableViewCell")
        }
        cell.setValues(title: lists[indexPath.row].title, icon: lists[indexPath.row].icon, count: lists[indexPath.row].tasks.count)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let list = lists[indexPath.row]
        lists.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        delegate?.deleteList(list)
    }
}

extension HomeView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectedList(lists[indexPath.row])
    }
}
