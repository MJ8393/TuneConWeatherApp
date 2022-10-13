//
//  File.swift
//  WeatherApp
//
//  Created by Mekhriddin Jumaev on 13/10/22.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    // MARK: Properties
    var mapView = MKMapView()
    var location: CLLocation?

    // MARK: ViewController Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setRootView()
    }
    
    // MARK: Functions
    func configureMap(_ location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)

        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(pin)
    }

}

// MARK: - Extension RootView
extension MapViewController: RootView {
    func configureUI() {
        view.backgroundColor = .systemBackground
        if let location = location {
            configureMap(location)
        }
    }
    
    func addSubviews() {
        view.addSubview(mapView)
    }
    
    func setConstraints() {
        mapView.snp.makeConstraints { make in
            make.size.equalTo(view)
        }
    }
}
