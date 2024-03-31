//
//  StorageManager.swift
//  TaskListApp
//
//  Created by Никита on 31.03.2024.
//

import Foundation
import CoreData

final class StorageManager {
    
    static let shared = StorageManager()
    
    private let context: NSManagedObjectContext

    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TaskListApp")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    private init() {
        context = persistentContainer.viewContext
    }
    
    func fetchData(completion: (Result<[Task], Error>) -> Void) {
        let fetchRequest = Task.fetchRequest()
        do {
            let task = try context.fetch(fetchRequest)
            completion(.success(task))
        } catch {
            completion(.failure(error))
        }
    }
    
    func saveTask(_ name: String, compeltion: (Task) -> Void) {
        let task = Task(context: context)
        task.title = name
        compeltion(task)
        saveContext()
    }
    
    func deleteTask(_ task: Task) {
        context.delete(task)
        saveContext()
    }
    
    func update(_ task: Task, newName: String) {
        task.title = newName
        saveContext()
    }

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
