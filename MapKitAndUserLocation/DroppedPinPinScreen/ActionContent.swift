//
//  ActionContent.swift
//  MapKitAndUserLocation
//
//  Created by Pedro Ésli Vieira do Nascimento on 01/12/21.
//

import Foundation

struct ActionContent{
    
    enum ContentType: String {
        case add = "Add to Annotation List"
        case save = "Save"
        case delete = "Delete"
        case cancel = "Cancel"
    }
    
    var type: ContentType
    var imageName: String
}
