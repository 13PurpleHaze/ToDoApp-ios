//
//  AddListView.swift
//  ToDoApp
//
//  Created by Никита Новицкий on 29.07.2025.
//

import UIKit

class AddListView: UIView {
    weak var delegate: AddListViewDelegate?
    
    private let fieldsStackView = UIStackView()
    private let titleLabel = FieldLabel(text: "Title")
    private let iconLabel = FieldLabel(text: "Icon")
    private let addListButton = MainButton(title: "Add list",color: .systemMint)
    private let titleField = UITextField()
    private let iconSelectorView = IconSelectorView()
    private var selectedIcon = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .systemBackground
        
        hideKeyboardWhenTappedAround()
        configureAddListButton()
        configureFieldsStackView()
    }
    
    private func configureFieldsStackView() {
        addSubview(fieldsStackView)
        fieldsStackView.translatesAutoresizingMaskIntoConstraints = false
        fieldsStackView.axis = .vertical
        fieldsStackView.spacing = 16
        
        configureTitle()
        configureIconSelectorView()
        
        NSLayoutConstraint.activate([
            fieldsStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            fieldsStackView.bottomAnchor.constraint(equalTo: addListButton.topAnchor, constant: -16),
            fieldsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            fieldsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    private func configureTitle() {
        titleField.placeholder = "Enter list name"
        titleField.delegate = self

        let fieldStackView = UIStackView()
        fieldStackView.addArrangedSubview(titleLabel)
        fieldStackView.addArrangedSubview(titleField)
        fieldStackView.axis = .vertical
        fieldStackView.spacing = 8
        fieldStackView.alignment = .fill
        
        fieldsStackView.addArrangedSubview(fieldStackView)
    }
    
    private func configureIconSelectorView() {
        iconSelectorView.delegate = self
        
        let fieldStackView = UIStackView()
        fieldStackView.addArrangedSubview(iconLabel)
        fieldStackView.addArrangedSubview(iconSelectorView)
        fieldStackView.axis = .vertical
        fieldStackView.spacing = 8
        
        fieldsStackView.addArrangedSubview(fieldStackView)
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
    
    @objc func addList() {
        guard !selectedIcon.isEmpty, let title = titleField.text else { return }
        let model = TasksListModel(id: UUID().uuidString, title: title, icon: selectedIcon, tasks: [], createdAt: .now)
        delegate?.addList(model)
    }
}

extension AddListView: IconSelectorViewDelegate {
    func selectIcon(_ icon: String) {
        selectedIcon = icon
    }
}

extension AddListView {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        endEditing(true)
    }
}

extension AddListView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
