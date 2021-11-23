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
        tableView.separatorColor = .white
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AnnotationCell")
    }
}

//MARK: Table view data source
extension AnnotationsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnnotationCell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = "Hey \(indexPath.row)"
        cell.backgroundColor = .backgroundSecondary
        return cell
    }
}
