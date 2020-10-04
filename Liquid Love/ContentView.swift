//
//  ContentView.swift
//  Liquid Love
//
//  Created by Adrian on 02.10.20.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Wine.entity(), sortDescriptors: []) var wines:
        FetchedResults<Wine>
    @State private var showingAddView = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("\(wines.count)")
            }
            .navigationBarItems(trailing: Button(action: { showingAddView.toggle() }, label: {
                Image(systemName: "plus")
            })
            )
            .sheet(isPresented: $showingAddView, content: {
                AddWineView().environment(\.managedObjectContext, moc)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
