//
//  ListCell.swift
//  ToDoApp
//
//  Created by Никита Новицкий on 29.07.2025.
//

import UIKit

class ListCell: UITableViewCell {
    static let reuseIdentifier = "ListCell"
    
    private let cellStackView = UIStackView()
    private let iconImageStackView = UIStackView()
    private let titleLabel = UILabel()
    private let countLabel = UILabel()
    private let iconImageView = UIImageView()
    
    
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
        
        configureIconImageView()
        titleLabel.font = .preferredFont(forTextStyle: .title3)
        cellStackView.addArrangedSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            cellStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            cellStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            cellStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cellStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    private func configureIconImageView() {
        iconImageStackView.addArrangedSubview(iconImageView)
        iconImageStackView.addArrangedSubview(countLabel)
        iconImageStackView.axis = .vertical
        iconImageStackView.spacing = 8
        
        countLabel.font = .preferredFont(forTextStyle: .caption2)
        countLabel.textColor = .systemMint
        iconImageView.contentMode = .scaleAspectFit
        
        cellStackView.addArrangedSubview(iconImageStackView)
    }
    
    func setValues(title: String, icon: String, count: Int = 0) {
        titleLabel.text = title
        iconImageView.image = UIImage(systemName: icon)
        iconImageView.image = iconImageView.image?.withTintColor(.systemMint, renderingMode: .alwaysOriginal)
        countLabel.text = "\(count) Tasks"
    }
}
