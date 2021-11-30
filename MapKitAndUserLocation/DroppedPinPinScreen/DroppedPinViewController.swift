//
//  DroppedPinViewController.swift
//  MapKitAndUserLocation
//
//  Created by Pedro Ésli Vieira do Nascimento on 23/11/21.
//

import UIKit
import CoreLocation

class DroppedPinViewController: UIViewController {
   
    var titleLabel: UILabel = {
       let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.attributedText = NSAttributedString(string: "Dropped Pin", attributes: [NSAttributedString.Key.kern: 0.54])
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    var closeButton: UIButton = {
        let button = UIButton()
        var imageConfig = UIImage.SymbolConfiguration(paletteColors: [.secondaryLabel, .tertiarySystemFill])
        imageConfig = imageConfig.applying(UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(UIImage(systemName: "xmark.circle.fill", withConfiguration: imageConfig), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    var contentView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var distanceLabel: UILabel = {
        let label = UILabel()
        label.isEnabled = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .secondaryLabel
        label.text = "0 m away"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var detailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.attributedText = NSAttributedString(string: "Details", attributes: [NSAttributedString.Key.kern: -0.38])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var detailContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundSecondary
        view.layer.cornerRadius = 9
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var addressDetailLabel = PEDetailLabel(titleText: "Address", bodyText: "Chácara 325\nTaguatinga\nBrasília - DF\n72444\nBrasil")
    
    var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var coordinatesDetailLabel = PEDetailLabel(titleText: "Coordinates", bodyText: "15,40054° S, 48,04333° O")
    
    var pinInputContentView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.backgroundColor = .backgroundSecondary
        view.layer.cornerRadius = 9
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var pinTitleInputField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Title"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var lineView2: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var notesTextField: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    var actionTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(), style: .insetGrouped)
        tableView.isScrollEnabled = false
        tableView.separatorColor = .gray
        tableView.backgroundColor = .clear
        //Compensate for the top content pading to remove content clipping
        tableView.contentInset = UIEdgeInsets(top: -35, left: 0, bottom: 0, right: 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var delegate: DroppedPinDelegate?
    var isAddMode = true
    
    let addContents = [
        ActionContent(text: "Add to Annotation List", imageName: "plus.circle.fill"),
        ActionContent(text: "Cancel", imageName: "xmark.circle.fill")
    ]
    
    let editContents = [
        ActionContent(text: "Delete", imageName: "trash.circle.fill"),
        ActionContent(text: "Cancel", imageName: "xmark.circle.fill")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView(){
        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(distanceLabel)
        contentView.addSubview(detailLabel)
        contentView.addSubview(detailContentView)
        contentView.addSubview(pinInputContentView)
        contentView.addSubview(actionTableView)
        detailContentView.addSubview(addressDetailLabel)
        detailContentView.addSubview(lineView)
        detailContentView.addSubview(coordinatesDetailLabel)
        pinInputContentView.addSubview(pinTitleInputField)
        pinInputContentView.addSubview(lineView2)
        pinInputContentView.addSubview(notesTextField)
        
        pinTitleInputField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        NSLayoutConstraint.activate([
            //Title Label
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            //Close Button
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            //Scroll View +
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            //Content View ++
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 900),
            //Distance Label
            distanceLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            distanceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            distanceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            //Detail Label
            detailLabel.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor, constant: 15),
            detailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            detailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            //Detail Content View +++
            detailContentView.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 10),
            detailContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            detailContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            detailContentView.bottomAnchor.constraint(equalTo: coordinatesDetailLabel.bottomAnchor, constant: 15),
            //Address Detail Label
            addressDetailLabel.topAnchor.constraint(equalTo: detailContentView.topAnchor, constant: 15),
            addressDetailLabel.leadingAnchor.constraint(equalTo: detailContentView.leadingAnchor, constant: 16),
            addressDetailLabel.trailingAnchor.constraint(equalTo: detailContentView.trailingAnchor, constant: -16),
            //Line View
            lineView.topAnchor.constraint(equalTo: addressDetailLabel.bottomAnchor, constant: 15),
            lineView.leadingAnchor.constraint(equalTo: detailContentView.leadingAnchor, constant: 16),
            lineView.trailingAnchor.constraint(equalTo: detailContentView.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 0.5),
            //Coordinates Detail Label
            coordinatesDetailLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 15),
            coordinatesDetailLabel.leadingAnchor.constraint(equalTo: detailContentView.leadingAnchor, constant: 16),
            coordinatesDetailLabel.trailingAnchor.constraint(equalTo: detailContentView.trailingAnchor, constant: -16),
            //Pin Input View +++
            pinInputContentView.topAnchor.constraint(equalTo: detailContentView.bottomAnchor, constant: 16),
            pinInputContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            pinInputContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            pinInputContentView.heightAnchor.constraint(equalToConstant: 250),
            //Pin Title Input
            pinTitleInputField.topAnchor.constraint(equalTo: pinInputContentView.topAnchor, constant: 15),
            pinTitleInputField.leadingAnchor.constraint(equalTo: pinInputContentView.leadingAnchor, constant: 16),
            pinTitleInputField.trailingAnchor.constraint(equalTo: pinInputContentView.trailingAnchor, constant: -16),
            //Line View 2
            lineView2.topAnchor.constraint(equalTo: pinTitleInputField.bottomAnchor, constant: 15),
            lineView2.leadingAnchor.constraint(equalTo: pinInputContentView.leadingAnchor, constant: 16),
            lineView2.trailingAnchor.constraint(equalTo: pinInputContentView.trailingAnchor),
            lineView2.heightAnchor.constraint(equalToConstant: 0.5),
            //Notes Text View
            notesTextField.topAnchor.constraint(equalTo: lineView2.bottomAnchor, constant: 15),
            notesTextField.leadingAnchor.constraint(equalTo: pinInputContentView.leadingAnchor, constant: 16),
            notesTextField.trailingAnchor.constraint(equalTo: pinInputContentView.trailingAnchor, constant: -16),
            notesTextField.bottomAnchor.constraint(equalTo: pinInputContentView.bottomAnchor, constant: -15),
            //Action Table View
            actionTableView.topAnchor.constraint(equalTo: pinInputContentView.bottomAnchor, constant: 16),
            actionTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0), //insetGrouped already has 16 padding left and right
            actionTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            actionTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
            //actionTableView.heightAnchor.constraint(equalToConstant: tableViewHeight)
        ])
        
        //scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        
        actionTableView.register(ActionTableViewCell.self, forCellReuseIdentifier: ActionTableViewCell.identifier)
        actionTableView.dataSource = self
        actionTableView.delegate = self
    }
    
    func setDropedPin(droppedPinLocationCoordinate: CLLocationCoordinate2D){
        let pinLocation = CLLocation(latitude: droppedPinLocationCoordinate.latitude, longitude: droppedPinLocationCoordinate.longitude)
        
        if let userLocation = CLLocationManager().location {
            distanceLabel.isEnabled = true
            let distance = userLocation.distance(from: pinLocation)
            let distanceString = distance < 1000 ? "\(Int(distance.rounded())) m" : String(format: "%.1f", distance/1000) + " km"
            distanceLabel.text = distanceString + " away"
        }
        
        let latitude = droppedPinLocationCoordinate.latitude
        let longitude = droppedPinLocationCoordinate.longitude
        let latitudeText = String(format: "%.6f", latitude.magnitude) + "° " + (latitude > 0 ? "N" : "S")
        let longitudeText = String(format: "%.6f", longitude.magnitude) + "° " + (longitude > 0 ? "E" : "W")
        coordinatesDetailLabel.setDetailText(latitudeText + ", " + longitudeText)
        
        Task {
            do{
                let placemarks = try await CLGeocoder().reverseGeocodeLocation(pinLocation)
                guard let placemark = placemarks.first else { return }
                
                let name = placemark.name ?? ""
                var locality = placemark.locality ?? ""
                let subLocality = placemark.subLocality ?? ""
                let administrativeArea = placemark.administrativeArea ?? ""
                let postalCode = placemark.postalCode ?? ""
                let country = placemark.country ?? ""
                
                if !locality.isEmpty && !administrativeArea.isEmpty{
                    locality += " - "
                }
                
                addressDetailLabel.setDetailText("\(name)\n\(subLocality)\n\(locality)\(administrativeArea)\n\(postalCode)\n\(country)")
            }
            catch{
                print("Reverse Geocode Location Error: \(error)")
            }
        }
    }
    
    @objc func closeButtonPressed(){
        view.endEditing(true)
        delegate?.droppedPinCloseButtonPressed()
    }
}

extension DroppedPinViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isAddMode ? addContents.count : editContents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ActionTableViewCell.identifier, for: indexPath) as! ActionTableViewCell
        
        cell.setCell(actionContent: isAddMode ? addContents[indexPath.row] : editContents[indexPath.row])
        
        return cell
    }
}

extension DroppedPinViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAction = isAddMode ? addContents[indexPath.row] : editContents[indexPath.row]
        
        if selectedAction.text == "Cancel" {
            closeButtonPressed()
        }
    }
}
