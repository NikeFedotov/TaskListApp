//
//  TaskViewController.swift
//  TaskListApp
//
//  Created by Никита on 25.03.2024.
//

import UIKit

final class TaskViewController: UIViewController {
    
    private lazy var taskTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "New Task"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private lazy var saveButton: UIButton = {
        FilledButtonFactory(
            title: "Save task",
            color: UIColor(named: "MilkBlue") ?? .white,
            action: UIAction { [unowned self] _ in
                save()
            }
        ).createButton()
    }()
    
    private lazy var cancelButton: UIButton = {
        FilledButtonFactory(
            title: "Cancel",
            color: UIColor(named: "MilkRed") ?? .white,
            action: UIAction { [unowned self] _ in
                dismiss(animated: true)
            }
        ).createButton()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews(taskTextField, saveButton, cancelButton)
        setupConstraints()

    }

}

// MARK: - Private Methods
private extension TaskViewController {
    func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    func save() {
        dismiss(animated: true)
    }
    
}

// MARK: - Layout
private extension TaskViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            taskTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            taskTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            taskTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            saveButton.topAnchor.constraint(equalTo: taskTextField.bottomAnchor, constant: 40),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            cancelButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 40),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
        ])
    }
}
