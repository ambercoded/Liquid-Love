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
    let categories = ["Weißwein", "Rotwein", "Roséwein"]
    let tasteCategories = ["Trocken", "Halbtrocken", "Lieblich"]
    
    @State private var name = ""
    @State private var price = ""
    @State private var isFavorite = false
    @State private var rating = 3
    @State private var notes = ""
    @State private var placeOfPurchase = ""
    
    @State private var category = "Weißwein"
    @State private var tasteCategory = "Trocken"
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text:$name)
                    Picker("Kategorie", selection: $category) {
                        ForEach(categories, id:\.self) {
                            Text($0)
                        }
                    }
                    Picker("Geschmack", selection: $tasteCategory) {
                        ForEach(tasteCategories, id:\.self) {
                            Text($0)
                        }
                    }
                    TextField("Preis", text:$price)
                        .keyboardType(.decimalPad)
                    
                }
                
                Section {
                    RatingView(rating: $rating)
                    TextField("Notizen", text:$notes)
                }
                
                Section {
                    Button("Wein eintragen") {
                        saveWine()
                    }
                }
            }.navigationBarTitle("Wein hinzufügen")
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
    }
}
