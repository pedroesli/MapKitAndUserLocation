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
        titleLabel.font = UIFont.boldSystemFont(ofSize: 27)
        titleLabel.attributedText = NSAttributedString(string: "Dropped Pin", attributes: [NSAttributedString.Key.kern: 0.54])
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    var closeButton: UIButton = {
        let button = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .bold)
        button.setImage(UIImage(systemName: "xmark", withConfiguration: imageConfig), for: .normal)
        button.setBackgroundImage(UIImage(named: "CloseButtonBackground"), for: .normal)
        button.tintColor = .secondaryLabel
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        //scrollView.backgroundColor = .red
        return scrollView
    }()
    
    var contentView: UIView = {
        let view = UIView()
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
    
    var delegate: DroppedPinDelegate?
    
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
        detailContentView.addSubview(addressDetailLabel)
        detailContentView.addSubview(lineView)
        detailContentView.addSubview(coordinatesDetailLabel)
        
        NSLayoutConstraint.activate([
            //Title Label
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            //Close Button
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
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
            coordinatesDetailLabel.trailingAnchor.constraint(equalTo: detailContentView.trailingAnchor, constant: -16)
        ])
        
        //scrollView.contentSize = CGSize(width: view.frame.width, height: 1000)
        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
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
        delegate?.droppedPinCloseButtonPressed()
    }
}
