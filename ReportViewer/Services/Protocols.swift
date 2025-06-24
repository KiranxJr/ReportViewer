//
//  Protocols.swift
//  ReportViewer
//
//  Created by admin on 23/06/25.
//

protocol APIServiceProtocol {
    func fetchObjects(completion: @escaping ([APIObject]) -> Void)
}

protocol CoreDataServiceProtocol {
    func fetchItems() -> [ItemEntity]
    func saveItem(from object: APIObject)
    func delete(_ item: ItemEntity)
    func update(_ item: ItemEntity, newName: String)
}
