import SwiftUI
import _MapKit_SwiftUI
struct ContentView: View {
	@EnvironmentObject var stateController: StateController
	@State private var usersOnMap = false //.sheet med users (vises ikke pr. default)
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
						Map(coordinateRegion: .constant(MKCoordinateRegion(center: user.coordinate, span: MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50))), annotationItems: [user]) { user in
							MapMarker(coordinate: user.coordinate)
						}
						.padding()
						.frame(width: 80, height: 80)
						.cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
						.blur(radius: 4)

						Text("\(user.name.first) \(user.name.last)")
					}
				}
			}
			.navigationTitle(Text("Random Users"))
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
			HStack{
				ImageView(user: user, size: 120, region: $stateController.region)
				VStack{
					Text("\(user.name.first) \(user.name.last)")
						.font(.title)
						.lineLimit(3)
						
					Text("\(user.location.city)")
						.foregroundColor(.accentColor)
						.font(.title)
				}
			}
			.padding()
			
			Map(coordinateRegion: .constant(MKCoordinateRegion(center: user.coordinate, span: MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20))), annotationItems: [user]) { user in
				MapMarker(coordinate: user.coordinate)
			}
			.frame(height: 400)
			.saturation(2)
			.cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
			
			
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

