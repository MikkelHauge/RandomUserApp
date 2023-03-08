//
//  MapView.swift
//  RandomUserApp
//
//  Created by Mikkel Hauge on 08/03/2023.
//

import SwiftUI
import MapKit

struct MapView: View {
	@Environment(\.presentationMode) var presentationMode
	
	@EnvironmentObject var stateController: StateController

	
	var users: [User]
	
	
	var body: some View {
		Map(coordinateRegion: $stateController.region, annotationItems: users) { user in
			MapMarker(coordinate: user.coordinate)
		}
		.navigationTitle(Text("All Users"))
		.navigationBarTitleDisplayMode(.inline)
		.toolbar {
			ToolbarItem(placement: .navigationBarLeading) {
				Button("Done") {
					presentationMode.wrappedValue.dismiss()
				}
			}
		}
		.onAppear {
			let coordinates = users.map(\.coordinate)
		}
	}
}
