//
//  FieldLabel.swift
//  ToDoApp
//
//  Created by Никита Новицкий on 29.07.2025.
//

import UIKit

class FieldLabel: UILabel {
    init(text: String, alignment: NSTextAlignment = .left) {
        super.init(frame: .zero)
        configure(text: text, alignment: alignment)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(text: String, alignment: NSTextAlignment = .left) {
        self.text = text
        font = .preferredFont(forTextStyle: .body)
    }
}
