//
//  CDHolder+CoreDataProperties.swift
//  MapKitAndUserLocation
//
//  Created by Pedro Ésli Vieira do Nascimento on 30/11/21.
//
//

import Foundation
import CoreData


extension CDHolder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDHolder> {
        return NSFetchRequest<CDHolder>(entityName: "CDHolder")
    }

    @NSManaged public var annotations: NSOrderedSet?

}

// MARK: Generated accessors for annotations
extension CDHolder {

    @objc(insertObject:inAnnotationsAtIndex:)
    @NSManaged public func insertIntoAnnotations(_ value: CDAnnotation, at idx: Int)

    @objc(removeObjectFromAnnotationsAtIndex:)
    @NSManaged public func removeFromAnnotations(at idx: Int)

    @objc(insertAnnotations:atIndexes:)
    @NSManaged public func insertIntoAnnotations(_ values: [CDAnnotation], at indexes: NSIndexSet)

    @objc(removeAnnotationsAtIndexes:)
    @NSManaged public func removeFromAnnotations(at indexes: NSIndexSet)

    @objc(replaceObjectInAnnotationsAtIndex:withObject:)
    @NSManaged public func replaceAnnotations(at idx: Int, with value: CDAnnotation)

    @objc(replaceAnnotationsAtIndexes:withAnnotations:)
    @NSManaged public func replaceAnnotations(at indexes: NSIndexSet, with values: [CDAnnotation])

    @objc(addAnnotationsObject:)
    @NSManaged public func addToAnnotations(_ value: CDAnnotation)

    @objc(removeAnnotationsObject:)
    @NSManaged public func removeFromAnnotations(_ value: CDAnnotation)

    @objc(addAnnotations:)
    @NSManaged public func addToAnnotations(_ values: NSOrderedSet)

    @objc(removeAnnotations:)
    @NSManaged public func removeFromAnnotations(_ values: NSOrderedSet)

}

extension CDHolder : Identifiable {

}
