//
//  DetailWineView.swift
//  Liquid Love
//
//  Created by Adrian on 10.10.20.
//

import SwiftUI
import CoreData

struct DetailWineView: View {
    let wine: Wine
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(wine.category ?? "Red Wine")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geo.size.width)
                    
                    Text("\(wine.tasteCategory ?? "Harsh") \(wine.category ?? "Black Wine")")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color(.black).opacity(0.7))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
                
                Text("\"\(wine.notes ?? "notes placeholder")\"")
                    .padding()
                
                RatingView(rating: .constant(Int(wine.rating)))
                
                Text("\(wine.price ?? "1000€") €")
                    .font(.caption)
                    .padding()
            }
        }
        .navigationBarTitle(wine.name ?? "No name Wine")
    }
    
}

struct DetailWineView_Previews: PreviewProvider {
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
            DetailWineView(wine: wine)
        }
    }
}
