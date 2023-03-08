
import SwiftUI
import CoreLocation
import MapKit
class StateController: ObservableObject {
	
	@Published var users: [User] = []  //same as @Published var users = [User]()
	@Published var region = MKCoordinateRegion(
		center: CLLocationCoordinate2D(latitude: 56.334_900,
									   longitude: 10.009_020),
		latitudinalMeters: 250200,
		longitudinalMeters: 250200
	)
	
	init() {
		guard let randomUserUrl = URL(string: "https://randomuser.me/api/?nat=DK&results=15") else { return }
		fetchUsers(from: randomUserUrl)
	}

	func fetchUsers(from url: URL) {
		Task(priority: .medium) {
			guard let rawUserData = await NetworkService.getData(from: url) else { return }
			let decoder = JSONDecoder()
			
			do {
				let decodedRandomUserResult = try decoder.decode(RandomUserResult.self, from: rawUserData)
				users = decodedRandomUserResult.results
			} catch {
				fatalError("Error while converting rawUserData to RandomUserResult instance")
			}
			
		}
		
	}
	
}
