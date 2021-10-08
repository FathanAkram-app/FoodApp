//
//  Details.swift
//  FoodApp
//
//  Created by Fathan Akram on 08/10/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct Details: View {
    var item: Item
    
    var body: some View {
        VStack(alignment: .center){
            
                ScrollView{
                    HStack(alignment: .center){
                        
                        Image(systemName: "star.fill")
                            .accentColor(.black)
                        Text(item.item_rating)
                            .accentColor(.black)
                        Spacer()
                        
                        Text("$\(item.item_cost)")
                            .foregroundColor(.green)
                        
                        
                    }
                    .padding(.top)
                    
                    
                    WebImage(url: URL(string: item.item_image))
                        .resizable()
                        .scaledToFill()
                        .frame(width: .infinity, height: 200)
                        .padding()
                        
                    
                    Text(item.item_name)
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                        .padding()
                        .accentColor(.black)
                        .fixedSize(horizontal: false, vertical: true)
                    Text(item.item_details)
                        .font(.system(size: 14))
                        .accentColor(.black)
                        .fixedSize(horizontal: false, vertical: true)
                    
                        
                }
                .frame(maxWidth: .infinity,  maxHeight: .infinity, alignment: .center)
                .padding()
                .background(Color.white)
                .frame(width: UIScreen.main.bounds.width / 1.2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .cornerRadius(10)
            
            
            
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .shadow(radius: 4 )
        .padding(.top, 16)
    }
}

struct Details_Previews: PreviewProvider {
    static var previews: some View {
        Details(item: Item(id: "awsd", item_name: "dada", item_cost: 12, item_details: "sdadasada", item_image: "https://cdn.sanity.io/images/czqk28jt/prod_bk_us/7ce8074a996ea7e84ee3ce9c48430e3000b356fc-1333x1333.png?w=750&q=40&fit=max&auto=format", item_rating: "4.2"))
    }
}
