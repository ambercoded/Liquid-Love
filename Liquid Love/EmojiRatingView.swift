//
//  EmojiRatingView.swift
//  Liquid Love
//
//  Created by Adrian on 06.10.20.
//

import SwiftUI

struct EmojiRatingView: View {
    let rating: Int16
    var body: some View {
        switch rating {
        case 1:
            Text("😖")
        case 2:
            Text("🙁")
        case 3:
            Text("😐")
        case 4:
            Text("😊")
        case 5:
            Text("😍")
        default:
            Text("no rating")
        }
        
    }
}

struct EmojiRatingView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiRatingView(rating: 3)
    }
}
