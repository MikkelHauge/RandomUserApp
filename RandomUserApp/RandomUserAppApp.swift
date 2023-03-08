//
//  RandomUserAppApp.swift
//  RandomUserApp
//
//  Created by tim on 01/03/2023.
//

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
