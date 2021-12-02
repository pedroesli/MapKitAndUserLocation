//
//  AnnotationDelegate.swift
//  MapKitAndUserLocation
//
//  Created by Pedro Ésli Vieira do Nascimento on 01/12/21.
//

import Foundation

protocol AnnotationDelegate{
    func annotation(pressedAnnotation annotation: CDAnnotation, at indexPath: IndexPath)
}
