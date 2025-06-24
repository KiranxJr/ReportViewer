//
//  ItemEntity+CoreDataProperties.swift
//  ReportViewer
//
//  Created by admin on 23/06/25.
//
//

import Foundation
import CoreData


extension ItemEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemEntity> {
        return NSFetchRequest<ItemEntity>(entityName: "ItemEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?

}

extension ItemEntity : Identifiable {

}
