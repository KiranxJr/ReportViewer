//
//  CoreDataViewModel.swift
//  ReportViewer
//
//  Created by admin on 20/06/25.
//

import Foundation
import CoreData

class CoreDataViewModel: ObservableObject {
    @Published var items: [ItemEntity] = []
    private let apiService: APIServiceProtocol
    private let context: NSManagedObjectContext

    init(apiService: APIServiceProtocol = APIService.shared) {
        self.apiService = apiService
        self.context = CoreDataManager.shared.context
        fetchItems()
    }

    func fetchItems() {
        let request: NSFetchRequest<ItemEntity> = ItemEntity.fetchRequest()
        do {
            items = try context.fetch(request)
        } catch {
            print("Fetch Core Data error:", error)
        }
    }

    func fetchFromAPIAndStore() {
        apiService.fetchObjects { [weak self] objects in
            DispatchQueue.main.async {
                objects.forEach { self?.saveItem(from: $0) }
                self?.fetchItems()
            }
        }
    }

    func saveItem(from object: APIObject) {
        guard !object.name.isEmpty else { return }

        let newItem = ItemEntity(context: context)
        newItem.id = object.id.isEmpty ? UUID().uuidString : object.id
        newItem.name = object.name
        CoreDataManager.shared.save()
    }

    func updateItem(_ item: ItemEntity, newName: String) {
        guard !newName.isEmpty else { return }
        item.name = newName
        CoreDataManager.shared.save()
        fetchItems()
    }

    func deleteItem(_ item: ItemEntity) {
        let itemName = item.name ?? "Unnamed"

        context.delete(item)
        CoreDataManager.shared.save()
        fetchItems()

        let notificationsEnabled = UserDefaults.standard.bool(forKey: "notifications_enabled")
        if notificationsEnabled {
            NotificationService.schedule(title: "Item Deleted", message: itemName) 
        }
    }

}
