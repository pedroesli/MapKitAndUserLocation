//
//  AnnotationsViewController.swift
//  MapKitAndUserLocation
//
//  Created by Pedro Ésli Vieira do Nascimento on 22/11/21.
//

import UIKit

class AnnotationsViewController: UIViewController{
    
    var tableView: UITableView = UITableView(frame: CGRect(), style: .insetGrouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    //MARK: Methods
    func setupView(){
        view.backgroundColor = .clear
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorColor = .gray
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
