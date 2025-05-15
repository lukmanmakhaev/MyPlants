//
//  Plant+CoreDataProperties.swift
//  MyPlants
//
//  Created by Lukman Makhaev on 13.05.2025.
//
//

import Foundation
import CoreData

extension Plant {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Plant> {
        return NSFetchRequest<Plant>(entityName: "Plant")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var descriptionText: String?
    @NSManaged public var family: String?
    @NSManaged public var genus: String?
    @NSManaged public var id: UUID?
    @NSManaged public var imageUrls: [String]? 
    @NSManaged public var kingdom: String?
    @NSManaged public var commonName: String?
    @NSManaged public var name: String?
    @NSManaged public var order: String?
    @NSManaged public var phylum: String?
    @NSManaged public var plantClass: String?
    @NSManaged public var probability: Double

}

extension Plant: Identifiable {

}
