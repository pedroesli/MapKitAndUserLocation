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
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    convenience init(titleText: String, bodyText: String){
        self.init()
        isUserInteractionEnabled = true
        numberOfLines = 0
        translatesAutoresizingMaskIntoConstraints = false
        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(showMenu(sender:))))
        
        title = titleText
        body = bodyText
        
        setText(titleText: titleText, bodyText: bodyText)
    }
    
    override func copy(_ sender: Any?) {
        let board = UIPasteboard.general
        board.string = body
        let menu = UIMenuController.shared
        menu.hideMenu()
    }
    
    @objc func showMenu(sender: AnyObject?){
        becomeFirstResponder()
        let menu = UIMenuController.shared
        if !menu.isMenuVisible{
            menu.showMenu(from: self, rect: bounds)
        }
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.copy(_:)){
            return true
        }
        return false
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
