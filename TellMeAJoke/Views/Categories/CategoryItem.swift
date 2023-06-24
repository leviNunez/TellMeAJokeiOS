//
//  CategoryItem.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 22/6/23.
//

import SwiftUI
import Combine

struct CategoryItem: View {
    var category: Joke.Category
    
    var body: some View {
        VStack {
            Image(category.rawValue.capitalized)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(category.rawValue.capitalized)
                .modifier(JokeTextModifier())
                .lineLimit(1)
        }
        .frame(width: 120, height: 120)
        .padding()
    }
}

struct CategoryItem_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItem(category: .programming)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(ColorAsset.primary))
    }
}
