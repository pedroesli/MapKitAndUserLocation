//
//  DroppedPinDelegate.swift
//  MapKitAndUserLocation
//
//  Created by Pedro Ésli Vieira do Nascimento on 24/11/21.
//

import Foundation

protocol DroppedPinDelegate{
    func droppedPinCanClose()
    func droppedPin(canDeleteAt indexPath: IndexPath)
    func droppedPin(addedAnnotation annotation: CDAnnotation)
    func droppedPin(editedAnnotation annotation: CDAnnotation, at indexPath: IndexPath)
}
