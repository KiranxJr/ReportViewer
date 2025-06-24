//
//  CoreDataManager.swift
//  ReportViewer
//
//  Created by admin on 23/06/25.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()

    let container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(name: "AppModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("error: \(error.localizedDescription)")
            }
        }
    }

    var context: NSManagedObjectContext {
        return container.viewContext
    }

    func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("error:", error)
            }
        }
    }
}
