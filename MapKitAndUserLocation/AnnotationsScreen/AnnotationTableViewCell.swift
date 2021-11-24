//
//  AnnotationTableViewCell.swift
//  MapKitAndUserLocation
//
//  Created by Pedro Ésli Vieira do Nascimento on 23/11/21.
//

import UIKit

class AnnotationTableViewCell: UITableViewCell {

    static let identifier = "AnnotationCell"
    
    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var secondaryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .backgroundSecondary
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(primaryText: String, secondaryText: String){
        primaryLabel.text = primaryText
        secondaryLabel.attributedText = NSAttributedString(string: secondaryText, attributes: [NSAttributedString.Key.kern: 0.21])
    }
}
