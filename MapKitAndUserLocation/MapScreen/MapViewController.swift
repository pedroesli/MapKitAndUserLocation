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
    
    var floatingPanel = FloatingPanelController()
    var lastSelectedPin: MKPointAnnotation?
    
    let locationManager = CLLocationManager()
    let selectionGenerator = UIImpactFeedbackGenerator(style: .light)
    
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
        
        let contentVC = AnnotationsViewController()
        floatingPanel.set(contentViewController: contentVC)
        floatingPanel.track(scrollView: contentVC.tableView)
        floatingPanel.addPanel(toParent: self)
        floatingPanel.surfaceView.appearance.backgroundColor = .background
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
        selectionGenerator.prepare()
        longGesture.isEnabled = true
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
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            manager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
}

