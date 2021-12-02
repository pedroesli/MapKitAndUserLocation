//
//  DroppedPinDelegate.swift
//  MapKitAndUserLocation
//
//  Created by Pedro Ésli Vieira do Nascimento on 24/11/21.
//

import Foundation

protocol DroppedPinDelegate{
    func droppedPinCloseButtonPressed()
    func addedNewAnnotation(annotation: CDAnnotation)
}
