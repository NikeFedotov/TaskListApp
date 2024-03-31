//
//  FilledButtonFactory.swift
//  TaskListApp
//
//  Created by Никита on 27.03.2024.
//

import UIKit

protocol AlertFactories {
    func createAlertController(_ completion: @escaping (String) -> Void) -> UIAlertController
}

final class AlertControllerFactory {
    let userAction: UserAction
    let taskTitle: String?
    
    init(userAction: UserAction, taskTitle: String?) {
        self.userAction = userAction
        self.taskTitle = taskTitle
    }
}

extension AlertControllerFactory: AlertFactories {
    func createAlertController(_ completion: @escaping (String) -> Void) -> UIAlertController {
        let alert = UIAlertController(
            title: userAction.title,
            message: "What do you want to do",
            preferredStyle: .alert
        )
        let saveAction = UIAlertAction(
            title: "Save Task",
            style: .default) { _ in
                guard let task = alert.textFields?.first?.text, !task.isEmpty else { return }
                completion(task)
            }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        alert.addTextField { [weak self] textField in
            textField.placeholder = "NewTask"
            textField.text = self?.taskTitle
        }
        
        return alert
    }
}

// MARK: - UserAction
extension AlertControllerFactory {
    enum UserAction {
        case newTask
        case editTask
        
        var title: String {
            switch self {
            case .newTask:
                return "New Task"
            case .editTask:
                return "Edit Task"
            }
        }
    }
}
