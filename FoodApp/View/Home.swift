//
//  Home.swift
//  FoodApp
//
//  Created by Fathan Akram on 05/10/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct Home: View {
    @StateObject var homeViewModel = HomeViewModel()
    @State var cartCount: [String: Int] = ["":0]
    @State var showDetails:Bool = false
    @State var itemDetails: Item = Item(id: "", item_name: "", item_cost: 0, item_details: "", item_image: "", item_rating: "")
    var body: some View {
        ZStack{
            VStack(spacing:10){
                HStack(spacing:15){
                    Button(action: {
                        homeViewModel.showMenu = true
                    }, label: {
                        Image(systemName: "cart")
                            .font(.title)
                            .foregroundColor(.pink)
                    })
                    
                    Text(homeViewModel.userLocation == nil ? "Locating..." : "Deliver to")
                    
                    Text(homeViewModel.userAddress)
                        .font(.caption)
                        .fontWeight(.heavy)
                        .foregroundColor(.pink)
                    Spacer()
                    
                }
                .padding()
                Divider()
                HStack(spacing:15){
                    Image(systemName: "magnifyingglass")
                        .font(.title)
                        .foregroundColor(.gray)
                    TextField("Search", text: $homeViewModel.search)
                    
                }
                .padding(.horizontal)
                
                Divider()
                ScrollView(.vertical, showsIndicators: false, content:{
                    LazyVStack(alignment: .center, spacing: nil){
                        ForEach(homeViewModel.filtered) { item in
                            ItemView(item: item, cartCount: $cartCount,showDetails: $showDetails,itemDetails: $itemDetails)
                                .shadow(radius: 10)
                            
                        }
                    }
                })
                
            }
            
            ZStack{
                Menu(cartItems: cartCount,items: homeViewModel.items)
                    .offset(x: homeViewModel.showMenu ? -UIScreen.main.bounds.width + UIScreen.main.bounds.width / 1.225 : -UIScreen.main.bounds.width)
                    .animation(.easeIn)
                Spacer()
                Details(item: itemDetails)
                    .offset(x: showDetails ? 0 : -UIScreen.main.bounds.height)
                    .animation(.easeIn)
            }
            .background(Color.black
                            .opacity(homeViewModel.showMenu || showDetails ? 0.3 : 0)
                            .ignoresSafeArea()
                            .onTapGesture {
                                withAnimation(.easeIn){
                                    showDetails = false
                                    homeViewModel.showMenu = false
                                    
                                }
                            })
            
            if homeViewModel.noLocation {
                Text("Please enable location permission access")
                    .foregroundColor(.black)
                    .frame(width: UIScreen.main.bounds.width - 100, height: 120)
                    .background(Color.white)
                    .cornerRadius(10)
                    .frame(minWidth: .infinity, maxWidth: .infinity)
                    .background(Color.black.opacity(0.3).ignoresSafeArea())
            }
            
        }
        .onAppear(perform: {
            homeViewModel.locationManager.delegate = homeViewModel
            
        })
        .onChange(of: homeViewModel.search, perform: { value in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                if value == homeViewModel.search && homeViewModel.search != ""{
                    homeViewModel.filterData()
                }
            }
            
            if homeViewModel.search == ""{
                withAnimation(.linear){
                    homeViewModel.filtered = homeViewModel.items
                }
            }
            
        })
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
