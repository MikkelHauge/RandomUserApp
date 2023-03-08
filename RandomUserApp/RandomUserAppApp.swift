

import SwiftUI

@main
struct RandomUserAppApp: App {
	@StateObject var stateController = StateController()
	
    var body: some Scene {
        WindowGroup {
			ContentView(region: $stateController.region)
				.environmentObject(stateController)
        }
    }
}
