//
//  IconSelectorView.swift
//  ToDoApp
//
//  Created by Никита Новицкий on 29.07.2025.
//

import UIKit

class IconSelectorView: UIView {
    weak var delegate: IconSelectorViewDelegate?
    
    private var collectionView: UICollectionView!
    private let icons = Constants.icons
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .red
        translatesAutoresizingMaskIntoConstraints = false
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureLayout())
        addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(IconCell.self, forCellWithReuseIdentifier: IconCell.reuseIdentifier)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func configureLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 40, height: 40)
        return layout
    }
}

extension IconSelectorView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        icons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IconCell.reuseIdentifier, for: indexPath) as? IconCell else {
            return UICollectionViewCell()
        }
        cell.setImage(icons[indexPath.item])
        return cell
    }
}

extension IconSelectorView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.selectIcon(icons[indexPath.item])
    }
}
