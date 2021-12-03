//
//  ViewController.swift
//  MapKitAndUserLocation
//
//  Created by Pedro Ésli Vieira do Nascimento on 17/11/21.
//

import UIKit
import MapKit
import FloatingPanel

class MapViewController: UIViewController {

    var mapView: MKMapView = {
        let map = MKMapView()
        map.mapType = .standard
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    var annotationsFloatingPanel: FloatingPanelController = {
        let fp = FloatingPanelController()
        fp.surfaceView.appearance.backgroundColor = .background
        fp.surfaceView.appearance.cornerRadius = 10.0
        return fp
    }()
    
    var droppedPinFloatingPanel: FloatingPanelController = {
        let fp = FloatingPanelController()
        fp.surfaceView.appearance.backgroundColor = .background
        fp.surfaceView.appearance.cornerRadius = 10.0
        return fp
    }()
    
    var lastSelectedPin: MKPointAnnotation?
    
    let locationManager = CLLocationManager()
    let selectionGenerator = UIImpactFeedbackGenerator(style: .light)
    let annotationsVC = AnnotationsViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupMap()
        checkLocationServices()
        selectionGenerator.prepare()
    }

    func setupView(){
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        annotationsVC.delegate = self
        annotationsFloatingPanel.set(contentViewController: annotationsVC)
        annotationsFloatingPanel.track(scrollView: annotationsVC.tableView)
        annotationsFloatingPanel.addPanel(toParent: self)
        
        droppedPinFloatingPanel.addPanel(toParent: self)
        droppedPinFloatingPanel.move(to: .hidden, animated: false, completion: nil)
    }
    
    func setupMap(){
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress(longGesture:)))
        mapView.addGestureRecognizer(longGesture)
    }
    
    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func centerViewOnUserLocation(){
        guard let location = locationManager.location?.coordinate else { return }
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 800, longitudinalMeters: 800)
        mapView.setRegion(region, animated: true)
    }
    
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled(){
            // Setup our location manager
            setupLocationManager()
        } else {
            // Show alert letting the uer know they have to turn this on
            print("User Location Serices is disable. Please enable to use app properly")
        }
    }
    
    func showPinFloatingPanel(pinLocationCoordinate: CLLocationCoordinate2D, cdAnnotation: CDAnnotation? = nil, indexPath: IndexPath? = nil){
        let isAddMode = cdAnnotation == nil
        let pinContentVC = DroppedPinViewController(isAddMode: isAddMode)
        
        pinContentVC.delegate = self
        if let cdAnnotation = cdAnnotation, let indexPath = indexPath{
            pinContentVC.setDropedPin(cdAnnotation: cdAnnotation, indexPath: indexPath)
        }
        else{
            pinContentVC.setDropedPin(droppedPinLocationCoordinate: pinLocationCoordinate)
        }
        
        droppedPinFloatingPanel.set(contentViewController: pinContentVC)
        droppedPinFloatingPanel.track(scrollView: pinContentVC.scrollView)
        
        if droppedPinFloatingPanel.state == .hidden {
            annotationsFloatingPanel.move(to: .hidden, animated: true, completion: nil)
            droppedPinFloatingPanel.move(to: .half, animated: true)
        }
        else if droppedPinFloatingPanel.state == .tip {
            droppedPinFloatingPanel.move(to: .half, animated: true)
        }
    }
    
    @objc func didLongPress(longGesture: UILongPressGestureRecognizer){
        longGesture.isEnabled = false
        selectionGenerator.impactOccurred()
        
        let touchPoint = longGesture.location(in: mapView)
        let mapCoord = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        let pin = MKPointAnnotation()
        pin.coordinate = mapCoord
        
        if let lastSelectedPin = lastSelectedPin {
            mapView.removeAnnotation(lastSelectedPin)
        }
        mapView.addAnnotation(pin)
        mapView.selectAnnotation(pin, animated: true)
        lastSelectedPin = pin
        
        showPinFloatingPanel(pinLocationCoordinate: mapCoord)
        
        longGesture.isEnabled = true
    }
}

extension MapViewController: DroppedPinDelegate {
    func droppedPin(canDeleteAt indexPath: IndexPath) {
        annotationsVC.deleteFromTable(indexPath: indexPath)
    }
    
    func droppedPin(editedAnnotation annotation: CDAnnotation, at indexPath: IndexPath) {
        annotationsVC.editAnnotationAtTable(annotation: annotation, indexPath: indexPath)
    }
    
    
    func droppedPin(addedAnnotation annotation: CDAnnotation) {
        annotationsVC.insertIntoTable(annotation: annotation)
    }
    
    func droppedPinCanClose() {
        annotationsFloatingPanel.move(to: droppedPinFloatingPanel.state, animated: false) {
            self.droppedPinFloatingPanel.move(to: .hidden, animated: true, completion: nil)
        }
    }
}

extension MapViewController: AnnotationDelegate {
    func annotation(pressedAnnotation annotation: CDAnnotation, at indexPath: IndexPath) {
        let pinLocation = CLLocationCoordinate2D(latitude: annotation.latitude, longitude: annotation.longitude)
        showPinFloatingPanel(pinLocationCoordinate: pinLocation, cdAnnotation: annotation, indexPath: indexPath)
    }
}

extension MapViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else { return }
//        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
//        mapView.setRegion(region, animated: true)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus{
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            break
        case .denied:
            // Show alert instructing them how to turn on permissions
            break
        case .authorizedWhenInUse, .authorizedAlways:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            manager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
}


