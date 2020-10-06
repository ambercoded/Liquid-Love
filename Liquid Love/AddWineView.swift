//
//  AddWineView.swift
//  Liquid Love
//
//  Created by Adrian on 03.10.20.
//

import SwiftUI

struct AddWineView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    let categories = ["White wine", "Red wine", "Rosé wine"]
    let tasteCategories = ["Dry", "Semi-dry", "Sweet"]
    
    @State private var name = ""
    @State private var price = ""
    @State private var isFavorite = false
    @State private var rating = 3
    @State private var notes = ""
    @State private var placeOfPurchase = ""
    
    @State private var category = "White wine"
    @State private var tasteCategory = "Dry"
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Form {
                    Section {
                        TextField("Name", text:$name)
                        Picker("Category", selection: $category) {
                            ForEach(categories, id:\.self) {
                                Text($0)
                            }
                        }
                        Picker("Style", selection: $tasteCategory) {
                            ForEach(tasteCategories, id:\.self) {
                                Text($0)
                            }
                        }
                        TextField("Price", text:$price)
                            .keyboardType(.decimalPad)
                        
                    }
                    
                    Section {
                        RatingView(rating: $rating)
                        TextField("Some thoughts", text:$notes)
                    }
                    
                    Section {
                        Button("Store it in my cellar") {
                            saveWine()
                        }
                    }
                }
                
                
                    
            }.navigationBarTitle("Add a wine")
            .background(
                VStack {
                    HStack {
                        Spacer()
                        Spacer()
                        Image("wine")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            .frame(width: 450, alignment: .trailing)
                            .opacity(0.1)
                            .padding()
                        Spacer()
                    }
                    Spacer()
                })
                
        }
        
     
    }
    
    func saveWine() {
        let wine = Wine(context: moc)
        wine.name = name
        wine.category = category
        wine.tasteCategory = tasteCategory
        wine.price = price
        wine.rating = Int16(rating)
        wine.notes = notes
        
        do {
            try moc.save()
            self.presentationMode.wrappedValue.dismiss()
        } catch {
            print("saveWine: error")
        }
    }
}

struct AddWineView_Previews: PreviewProvider {
    static var previews: some View {
        AddWineView()
            .preferredColorScheme(.dark)
    }
}
