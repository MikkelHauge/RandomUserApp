//
//  LocationService.swift
//  RandomUserApp
//
//  Created by Mikkel Hauge on 08/03/2023.
//

import Foundation
import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate {
	private let locationManager = CLLocationManager()
	@Published var userLocation: CLLocationCoordinate2D?

	override init() {
		super.init()
		self.locationManager.delegate = self
		self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
		self.locationManager.requestWhenInUseAuthorization()
		self.locationManager.startUpdatingLocation()
	}

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let mostRecentLocation = locations.last else { return }
		userLocation = mostRecentLocation.coordinate
	}

	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print("Failed to get user location: \(error.localizedDescription)")
	}
}
