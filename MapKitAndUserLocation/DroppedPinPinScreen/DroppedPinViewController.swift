//
//  DroppedPinViewController.swift
//  MapKitAndUserLocation
//
//  Created by Pedro Ésli Vieira do Nascimento on 23/11/21.
//

import UIKit

class DroppedPinViewController: UIViewController {

    var titleLabel: UILabel = {
       let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 27)
        titleLabel.attributedText = NSAttributedString(string: "Dropped Pin", attributes: [NSAttributedString.Key.kern: 0.54])
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupView(){
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }
}
