//
//  HomeViewModel.swift
//  FoodApp
//
//  Created by Fathan Akram on 05/10/21.
//
import CoreLocation
import Foundation
import FirebaseAuth
import FirebaseFirestore
import SwiftUI


class HomeViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var locationManager = CLLocationManager()
    @Published var userLocation: CLLocation!
    
    @Published var userAddress = ""
    @Published var noLocation = false
    
    @Published var search = ""
    @Published var showMenu = false
    
    @Published var items: [Item] = []
    
    @Published var filtered: [Item] = []
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            print("authorized in use")
            self.noLocation = false
            manager.requestLocation()
        case .denied:
            print("denied")
            self.noLocation = true
        default:
            print("Unknown")
            self.noLocation = true
            locationManager.requestWhenInUseAuthorization()
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.userLocation = locations.last
        self.extractLocation()
        
        self.login()
    }
    
    func extractLocation(){
        CLGeocoder().reverseGeocodeLocation(self.userLocation){ (response, error) in
            guard let location = response else {return }
            
            var address = ""
            
            address += location.first?.name ?? ""
            address += ", "
            address += location.first?.locality ?? ""
            
            self.userAddress = address
        }
    }
    
    func login(){
        Auth.auth().signInAnonymously{ (response, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            print("Success = \(response!.user.uid)")
            self.fetchData()
            
        }
    }
    
    func fetchData(){
        let db = Firestore.firestore()
        
        db.collection("items").getDocuments{(response,error) in
            
            guard let itemData = response else {return }
            
            self.items = itemData.documents.compactMap( { (data)->Item? in
                return
                    Item(
                        id: data.documentID,
                        item_name: data.get("item_name") as! String,
                        item_cost: data.get("cost") as! Int,
                        item_details: data.get("item_details") as! String,
                        item_image: data.get("item_image") as! String,
                        item_rating: data.get("item_rating") as! String
                    )
            })
            self.filtered = self.items
        }
        
        
    }
    
    func filterData(){
        withAnimation(.linear){
            self.filtered = self.items.filter{
                return $0.item_name.lowercased().contains(self.search.lowercased())
            }
        }
    }
    
    
}
