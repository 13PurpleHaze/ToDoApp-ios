//
//  MainButton.swift
//  ToDoApp
//
//  Created by Никита Новицкий on 29.07.2025.
//

import UIKit

class MainButton: UIButton {
    init(title: String, color: UIColor) {
        super.init(frame: .zero)
        configure(title: title, color: color)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(title: String, color: UIColor) {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 8
        backgroundColor = color
        setTitle(title, for: .normal)
        titleLabel?.font = .preferredFont(forTextStyle: .title3)
    }
}
