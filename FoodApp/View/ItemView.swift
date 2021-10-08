//
//  ItemView.swift
//  FoodApp
//
//  Created by Fathan Akram on 06/10/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ItemView: View {
    var item: Item
    @Binding var cartCount : [String: Int]
    @Binding var showDetails: Bool
    @Binding var itemDetails: Item
    var body: some View {
        
        VStack(alignment: .center){
            
            VStack{
                HStack(alignment: .center){
                    
                    Image(systemName: "star.fill")
                        .accentColor(.black)
                    Text(item.item_rating)
                        .accentColor(.black)
                    Spacer()
                    Text("$\((cartCount[item.id] != nil) ? item.item_cost * cartCount[item.id]! : 0)")
                        .accentColor(.black)
                    Button(action: {
                        if cartCount[item.id] != nil && cartCount[item.id]! > 0{
                            cartCount[item.id]! -= 1
                        }
                    }, label: {
                        Text("-")
                            .frame(width: 20, height: 20, alignment: .center)
                            .background(Color.pink)
                            .cornerRadius(3.0)
                            .accentColor(.white)
                            
                    })
                    
                    Text("\((cartCount[item.id] != nil) ? cartCount[item.id]! : 0)")
                        .accentColor(.black)
                    Button(action: {
                        if cartCount[item.id] != nil {
                            cartCount[item.id]! += 1
                        }else{
                            cartCount[item.id] = 1
                        }
                        
                    }, label: {
                        Text("+")
                            .frame(width: 20, height: 20, alignment: .center)
                            .background(Color.pink)
                            .cornerRadius(3.0)
                            .accentColor(.white)
                    })
                    
                }
                .padding(.top)
                
                Button(action: {
                    showDetails = true
                    itemDetails = item
                }, label: {
                    VStack{
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
                    }
                    
                })
                
                    
                
                
                
                    
            }
            .frame(maxWidth: .infinity,  maxHeight: .infinity, alignment: .center)
            .padding()
            .background(Color.white)
            .frame(width: UIScreen.main.bounds.width / 1.2, height: UIScreen.main.bounds.height / 1.7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .cornerRadius(10)
            
            
            
            
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .shadow(radius: 4 )
        .padding(.top, 16)
        
        
        
        
    }
}


