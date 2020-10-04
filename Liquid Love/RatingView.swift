//
//  RatingView.swift
//  Liquid Love
//
//  Created by Adrian on 03.10.20.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    
    @State private var maximumRating = 5
    @State private var label = ""
    
    @State private var offImage: Image?
    @State private var onImage = Image(systemName: "star.fill")
    
    @State private var offColor = Color.gray
    @State private var onColor = Color.yellow
    
    var body: some View {
        HStack {
            Text(label)
            ForEach(1..<maximumRating+1) { number in
                self.image(for: number)
                    .foregroundColor(number > rating ? offColor : onColor)
                    .onTapGesture(perform: {
                        self.rating = number
                    })
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(3))
    }
}

