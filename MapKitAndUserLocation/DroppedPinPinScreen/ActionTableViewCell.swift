//
//  ActionTableViewCell.swift
//  MapKitAndUserLocation
//
//  Created by Pedro Ésli Vieira do Nascimento on 29/11/21.
//

import UIKit

class ActionTableViewCell: UITableViewCell {
    
    static let identifier = "ActionCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .red
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setCell(actionContent: ActionContent){
        //Content Configuration
        var content = self.defaultContentConfiguration()
        content.textProperties.color = .systemBlue
        content.text = actionContent.text
        content.axesPreservingSuperviewLayoutMargins = UIAxis.horizontal
        content.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0)
        
        var imageConfiguration = UIImage.SymbolConfiguration(paletteColors: [.systemBlue, .quaternarySystemFill])
        imageConfiguration = imageConfiguration.applying(UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .default))
        let image = UIImage(systemName: actionContent.imageName, withConfiguration: imageConfiguration)
        content.image = image
        
        self.contentConfiguration = content
        //Cell Appearance (needs to be after setting content config)
        backgroundColor = .backgroundSecondary
    }
}
