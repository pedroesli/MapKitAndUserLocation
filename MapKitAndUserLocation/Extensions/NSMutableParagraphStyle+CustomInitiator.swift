//
//  NSMutableParagraphStyle+CustomInitiator.swift
//  MapKitAndUserLocation
//
//  Created by Pedro Ésli Vieira do Nascimento on 24/11/21.
//

import UIKit

extension NSMutableParagraphStyle{
    convenience init(lineSpacing: CGFloat){
        self.init()
        self.lineSpacing = lineSpacing
    }
}
