//
//  CDAnnotation+CoreDataProperties.swift
//  MapKitAndUserLocation
//
//  Created by Pedro Ésli Vieira do Nascimento on 30/11/21.
//
//

import Foundation
import CoreData


extension CDAnnotation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDAnnotation> {
        return NSFetchRequest<CDAnnotation>(entityName: "CDAnnotation")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var title: String?
    @NSManaged public var notes: String?
    @NSManaged public var address: String?
    @NSManaged public var container: CDHolder?

}

extension CDAnnotation : Identifiable {

}
