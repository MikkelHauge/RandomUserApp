//
//  ContentView.swift
//  RandomUserApp
//
//  Created by tim on 01/03/2023.
//

import SwiftUI
import _MapKit_SwiftUI
struct ContentView: View {
	@EnvironmentObject var stateController: StateController
	@State private var usersOnMap = false
	@Binding var region: MKCoordinateRegion
	
	var lastNameSortedUsersers: [User] {
		stateController.users.sorted {
			$0.name.last < $1.name.last
		}
	}
	

	var body: some View {
		NavigationView{
			List(lastNameSortedUsersers) { user in
				NavigationLink(
					destination: UserDetailView(user: user)
				) {
					HStack{
						Map(coordinateRegion: .constant(MKCoordinateRegion(center: user.coordinate, span: MKCoordinateSpan(latitudeDelta: 30, longitudeDelta: 30))), annotationItems: [user]) { user in
							MapMarker(coordinate: user.coordinate)
						}
						.frame(width: 150, height: 150)

						Text("\(user.name.first) \(user.name.last)")
					}
				}
			}
			.navigationTitle(Text("Noobs"))
			.toolbar{
				ToolbarItem(placement: .navigationBarTrailing){
					Button(action: {
						usersOnMap = true
					}) {
						Image(systemName: "map")
					}
				}
			}
			.sheet(isPresented: $usersOnMap){
				VStack{
					MapView(users: stateController.users)
					Button(action: {
						usersOnMap = false
					}) {
						Image(systemName: "arrowshape.turn.up.backward.fill")
					}
				}
			}
		}
	}

}

struct UserDetailView: View {
	@EnvironmentObject var stateController: StateController

	
	let user: User

	var body: some View {
		VStack {
			Text("\(user.name.first) \(user.name.last)")
			Text("\(user.location.city)")
			ImageView(user: user, size: 10, region: $stateController.region)
			Map(coordinateRegion: .constant(MKCoordinateRegion(center: user.coordinate, span: MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20))), annotationItems: [user]) { user in
				MapMarker(coordinate: user.coordinate)
			}
			.frame(height: 400)
			
		}
		.padding()
	}
}
struct ImageView: View {
	let user: User
	let size: CGFloat
	@Binding var region: MKCoordinateRegion
	
	var body: some View {
		let url = URL(string: user.picture.large)!
		AsyncImage(url: url) { image in
			image
				.resizable()
				.frame(width: size, height: size)
				.clipShape(Circle())
				
		} placeholder: {
			LoadingView()
		}
	}
}


struct LoadingView: View {
	var body: some View {
		HStack{
			Label("Loading", systemImage: "clock")
				.foregroundColor(.white)
		}
		.frame(maxWidth: .infinity, maxHeight: 100)
		.background(.teal)
		.clipShape(RoundedRectangle(cornerRadius: 10))
		.padding()
	}
}

