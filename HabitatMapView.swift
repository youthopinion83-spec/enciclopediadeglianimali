import SwiftUI
import MapKit

struct HabitatMapView: View {
    @EnvironmentObject var repo: AnimalRepository
    var centerOn: Animal? = nil
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
                                                   span: MKCoordinateSpan(latitudeDelta: 40, longitudeDelta: 40))
    
    var body: some View {
        Map(position: .constant(.region(region)), interactionModes: .all, showsUserLocation: false, annotationItems: repo.animals) { a in
            MapMarker(coordinate: CLLocationCoordinate2D(latitude: a.lat, longitude: a.lng), tint: .green)
        }
        .onAppear {
            if let a = centerOn {
                region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: a.lat, longitude: a.lng),
                                            span: MKCoordinateSpan(latitudeDelta: 6, longitudeDelta: 6))
            }
        }
        .navigationTitle("Mappa habitat")
    }
}
