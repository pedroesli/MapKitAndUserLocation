//
//  AnnotationsViewController.swift
//  MapKitAndUserLocation
//
//  Created by Pedro Ésli Vieira do Nascimento on 22/11/21.
//

import UIKit

class AnnotationsViewController: UIViewController{
    
    var titleLabel: UILabel = {
       let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.attributedText = NSAttributedString(string: "My Pins", attributes: [NSAttributedString.Key.kern: 0.54])
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    var tableView: UITableView = {
        var tableView = UITableView(frame: CGRect(), style: .insetGrouped)
        tableView.backgroundColor = .clear
        tableView.separatorColor = .gray
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    //MARK: Methods
    func setupView(){
        view.backgroundColor = .clear
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            //Table View
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: "AnnotationTableViewCell", bundle: nil), forCellReuseIdentifier: AnnotationTableViewCell.identifier)
    }
}

//MARK: Table view data source
extension AnnotationsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AnnotationTableViewCell.identifier, for: indexPath) as! AnnotationTableViewCell
        cell.setCell(primaryText: "Hey \(indexPath.row)", secondaryText: "Sup")
        return cell
    }
}
