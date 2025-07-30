//
//  TaskCell.swift
//  ToDoApp
//
//  Created by Никита Новицкий on 29.07.2025.
//

import UIKit

protocol TaskCellDelegate: AnyObject {
    func updateTask(_ task: TaskModel)
}

class TaskCell: UITableViewCell {
    static let reuseIdentifier = "TaskCell"
    
    private let cellStackView = UIStackView()
    private let titleLabel = UILabel()
    private let iconImageView = UIImageView()
    private let checkBox = CheckBoxButton()
    private var task: TaskModel!
    
    weak var delegate: TaskCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.backgroundColor = .systemMint.withAlphaComponent(0.1)
        contentView.addSubview(cellStackView)
        
        cellStackView.layer.cornerRadius = 8
        cellStackView.axis = .horizontal
        cellStackView.translatesAutoresizingMaskIntoConstraints = false
        cellStackView.spacing = 16
        
        iconImageView.contentMode = .scaleAspectFit
        cellStackView.addArrangedSubview(iconImageView)
        titleLabel.font = .preferredFont(forTextStyle: .title3)
        titleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        iconImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        checkBox.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        cellStackView.addArrangedSubview(titleLabel)
        cellStackView.addArrangedSubview(checkBox)
        checkBox.addTarget(self, action: #selector(toggleCheck), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            cellStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            cellStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            cellStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cellStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    @objc func toggleCheck() {
        task.done.toggle()
        checkBox.setButtonChecked(task.done)
        delegate?.updateTask(task)
    }
    
    func setTask(_ task: TaskModel) {
        self.task = task
        titleLabel.text = task.title
        iconImageView.image = UIImage(systemName: task.icon)
        iconImageView.image = iconImageView.image?.withTintColor(.systemMint, renderingMode: .alwaysOriginal)
        checkBox.setButtonChecked(task.done)
    }
}
