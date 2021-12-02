//
//  AnnotationsViewController.swift
//  MapKitAndUserLocation
//
//  Created by Pedro Ésli Vieira do Nascimento on 22/11/21.
//

import UIKit
import FloatingPanel
import CoreLocation

class AnnotationsViewController: UIViewController {
    
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
    
    lazy var annotations: [CDAnnotation] = CoreDataManager.shared.fetchAllCDAnnotations()
    var delegate: AnnotationDelegate?
    
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
        tableView.delegate = self
        tableView.register(UINib(nibName: "AnnotationTableViewCell", bundle: nil), forCellReuseIdentifier: AnnotationTableViewCell.identifier)
    }
    
    func insertIntoTable(annotation: CDAnnotation){
        annotations.insert(annotation, at: 0)
        
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .top)
        tableView.endUpdates()
    }
}

//MARK: Table view data source
extension AnnotationsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return annotations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AnnotationTableViewCell.identifier, for: indexPath) as! AnnotationTableViewCell
        let annotation = annotations[indexPath.row]
        cell.setCell(primaryText: annotation.title ?? "My Pin", secondaryText: annotation.address ?? "")
        return cell
    }
}

//MARK: Table view delegate
extension AnnotationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.pressedRow(annotation: annotations[indexPath.row])
    }
}

