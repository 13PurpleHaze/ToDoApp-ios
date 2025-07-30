//
//  IconCell.swift
//  ToDoApp
//
//  Created by Никита Новицкий on 29.07.2025.
//

import UIKit

class IconCell: UICollectionViewCell {
    static let reuseIdentifier = "UICollectionViewCell"
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            setColor(color: isSelected ? .systemCyan : .systemMint)
        }
    }

    func setImage(_ name: String) {
        imageView.image = UIImage(systemName: name)
        imageView.contentMode = .scaleAspectFit
        setColor(color: .systemMint)
    }
    
    private func setColor(color: UIColor) {
        imageView.image = imageView.image?.withTintColor(color, renderingMode: .alwaysOriginal)
    }
    
    private func configure() {
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
