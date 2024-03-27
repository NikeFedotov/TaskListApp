//
//  TaskListViewController.swift
//  TaskListApp
//
//  Created by Никита on 24.03.2024.
//

import UIKit

final class TaskListViewController: UITableViewController {
    
    private let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private let cellID = "task"
    private var taskList: [Task] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        view.backgroundColor = .white
        setupNavigationBar()
        reloadData()
    }
    
    @objc
    private func addNewTask() {
        let taskVC = TaskViewController() // Создаем экземпляр класса, куда собираеся переходить
        taskVC.delegate = self
        present(taskVC, animated: true) // Метод презент есть у всех наследников UIViewController
    }

}

// MARK: - Private Methods
private extension TaskListViewController {
    func setupNavigationBar() {
        title = "Task List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let navBarAppearence = UINavigationBarAppearance()
        navBarAppearence.configureWithOpaqueBackground()
        
        navBarAppearence.backgroundColor = UIColor(named: "MilkBlue")
        
        navBarAppearence.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearence.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = navBarAppearence
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearence
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewTask)
        )
        
        navigationController?.navigationBar.tintColor = .white
            
    }
    
    func fetchData() {
        let request = Task.fetchRequest()
        do {
           taskList = try viewContext.fetch(request)
        } catch {
            print("Failed to fetch data", error)
        }
    }
}

// MARK: - UITableViewDataSource
extension TaskListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let task = taskList[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = task.title
        
        cell.contentConfiguration = content
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TaskListViewController {
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let object = taskList.remove(at: indexPath.row)
            viewContext.delete(object)
            do {
                try viewContext.save()
                tableView.deleteRows(at: [indexPath], with: .automatic)
            } catch {
                print(error)
            }
            
        }
    }
}

extension TaskListViewController: ITaskViewController {
    func reloadData() {
        fetchData()
        tableView.reloadData()
    }
}
