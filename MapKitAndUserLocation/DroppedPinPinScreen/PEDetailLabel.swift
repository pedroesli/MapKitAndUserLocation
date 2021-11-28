//
//  PEDetailLabel.swift
//  MapKitAndUserLocation
//
//  Created by Pedro Ésli Vieira do Nascimento on 24/11/21.
//

import UIKit

class PEDetailLabel: UILabel{
    
    private var title: String!
    private var body: String!
    
    convenience init(titleText: String, bodyText: String){
        self.init()
        numberOfLines = 0
        translatesAutoresizingMaskIntoConstraints = false
        
        title = titleText
        body = bodyText
        
        setText(titleText: titleText, bodyText: bodyText)
    }
    
    func setDetailText(_ text: String){
        body = text
        setText(titleText: title, bodyText: text)
    }
    
    private func setText(titleText: String, bodyText: String){
        let textContent = NSMutableAttributedString()
        textContent.append(titleAttributedText(titleText))
        textContent.append(bodyAttributedText(bodyText))
        
        attributedText = textContent
    }
    
    private func titleAttributedText(_ text: String) -> NSAttributedString{
        let attributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
            NSAttributedString.Key.kern: -0.07,
            NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel
        ] as [NSAttributedString.Key : Any]
        
        return NSAttributedString(string: text + "\n", attributes: attributes)
    }
    
    private func bodyAttributedText(_ text: String) -> NSAttributedString{
        let attributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17),
            NSAttributedString.Key.kern: -0.51,
            NSAttributedString.Key.paragraphStyle: NSMutableParagraphStyle(lineSpacing: 2)
        ] as [NSAttributedString.Key : Any]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    
}
