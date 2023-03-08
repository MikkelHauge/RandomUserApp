

import Foundation
import CoreLocation

struct User: Codable, Identifiable{
	let id = UUID().uuidString
	let name: Name
	let picture: PictureUrl
	let location: Location
	
	
	var fullName: String {
		"\(name.first) \(name.last)"
	}

	struct Location: Codable {
		let city: String
		let coordinates: Coordinates
		
		struct Coordinates: Codable {
			let latitude: String
			let longitude: String
		}

	}
	
	struct PictureUrl: Codable {
		let large, thumbnail: String
	}
	
	struct Name: Codable {
		let title, first, last: String
	}
}



extension User {
	var coordinate: CLLocationCoordinate2D {
		if let latitude = Double(location.coordinates.latitude),
			let longitude = Double(location.coordinates.longitude) {
			return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
		} else {
			return CLLocationCoordinate2D()
		}
	}
}
