//
//  ContentView.swift
//  Liquid Love
//
//  Created by Adrian on 02.10.20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Wine.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Wine.rating, ascending: false),
        NSSortDescriptor(keyPath: \Wine.name, ascending: true)
    ]) var wines:
        FetchedResults<Wine>
    @State private var showingAddView = false
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(wines, id: \.self) { wine in
                    NavigationLink(destination: DetailWineView(wine: wine)) {
                        
                        EmojiRatingView(rating: wine.rating)
                            .padding(.trailing, 8)
                        
                        VStack(alignment: .leading) {
                            Text(wine.name ?? "Unknown Wine Name")
                                .font(.headline)
                                .foregroundColor(wine.rating >= 2 ? .primary : .red)
                            Text("\(wine.tasteCategory ?? "Unknown Style") \(wine.category ?? "Unknown Category")")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteWines)
            }
            .navigationBarTitle("Wine cellar")
            
            .navigationBarItems(leading: EditButton(), trailing: Button(action: { showingAddView.toggle() }, label: {
                Image(systemName: "plus")
            })
            )
            .sheet(isPresented: $showingAddView, content: {
                AddWineView().environment(\.managedObjectContext, moc)
            })
        }
    }
    
    func deleteWines(at offsets: IndexSet) {
        for offset in offsets {
            let wine = wines[offset]
            moc.delete(wine)
        }
        
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let wine = Wine(context: moc)
        wine.name = "Ranger Blossom"
        wine.category = "White wine"
        wine.tasteCategory = "Sweet"
        wine.price = "2,99"
        wine.notes = "nothing bitter here"
        wine.rating = Int16(4)
        
        return NavigationView {
            ContentView()
        }
    }
}
