//
//  Menu.swift
//  FoodApp
//
//  Created by Fathan Akram on 05/10/21.
//

import SwiftUI

struct Menu: View {
    var cartItems : [String: Int]
    var items : [Item]
    
    
    func getData(ids:String) -> Item{
        return self.items.filter{return $0.id == ids}[0]
    }
    
    func countTotal() -> Int {
        var total: Int = 0
        
        for (key, value) in self.cartItems{
            if value>0{
                total += getData(ids: key).item_cost * value
            }
        }
        
        return total
    }
    
    var body: some View {
        VStack{
            
            HStack{
                Text("Cart")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Spacer()
                
                
            }.padding()
                
            
            
            ScrollView{
                ForEach(cartItems.sorted(by: >), id: \.key) { key, value in
                    if value>0{
                        let item: Item = getData(ids: key)
                        
                        HStack{
                            
                                Text("$\(item.item_cost) x \(value)")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color.black)
                                    .padding(4)
                                    .background(Color.white)
                                    .cornerRadius(100)
                                    
                            Text(item.item_name)
                                .font(.system(size: 12))
                                .foregroundColor(Color.white)
                        }
                        .padding()
                        .frame(width: UIScreen.main.bounds.width / 1.8, height: 80, alignment: .center)
                        .background(Color.pink)
                        .cornerRadius(10)
                        
                        
                    }
                    
                    
                }
                
//                for (name, count) in items {
//                    Text(name)
//                }
                
            }
            HStack{
                Text("Total : $\(countTotal())")
                Spacer()
                Button(action: {
                    
                }, label: {
                    Text("Order")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(6)
                        .background(countTotal() > 0 ? Color.green : Color.gray)
                        .cornerRadius(4)
                }).disabled(countTotal() > 0 ? false : true)
            }
            .padding()
            Divider()
            
            HStack{
                Spacer()
                
                Text("Version 0.1")
                    .fontWeight(.bold)
                    .foregroundColor(.pink)
            }.padding()
        }
        .padding([.top, .trailing])
        .frame(width: UIScreen.main.bounds.width / 1.6)
        .background(Color.white.ignoresSafeArea())
        
    }
}

