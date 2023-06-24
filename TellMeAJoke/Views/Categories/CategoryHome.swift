//
//  CategoryHome.swift
//  TellMeAJoke
//
//  Created by Levi Nunez on 22/6/23.
//

import SwiftUI

struct CategoryHome: View {
    private var repository: JokesRepository
    @State private var selectedItem: Joke.Category = .programming
    @State private var path = [Joke.Category]()
    
    init() {
        let service = NetworkManager()
        repository = DefaultJokesRepository(service: service)
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color(ColorAsset.primary)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    Text(StringResource.selectCategory)
                        .modifier(JokeTextModifier(size: 24))
                        .padding(.bottom,  30)
                    
                    HStack(spacing: 20) {
                        ForEach(Joke.Category.allCases, id: \.id) { category in
                            NavigationLink(value: category) {
                                if category.id == selectedItem.id {
                                    AnimatedCategoryItem(category: category)
                                        .onTapGesture {
                                            selectedItem = category
                                        }
                                } else {
                                    CategoryItem(category: category)
                                        .onTapGesture {
                                            selectedItem = category
                                        }
                                }
                            }
                            
                        }
                    }
                    
                    Spacer()
                    
                    ImageButton(image: ImageAsset.start, title: StringResource.start) {
                        path = [selectedItem]
                    }
                    
                    Spacer()
                }
            }
            .navigationDestination(for: Joke.Category.self) { category in
                JokeHost(category: category, viewModel: JokesViewModel(repository: repository))
            }
        }
    }
}

struct AnimatedCategoryItem: View {
    var category: Joke.Category
    @State private var opacityValue = 0.2
    
    var body: some View {
        CategoryItem(category: category)
            .overlay(
                Rectangle()
                    .stroke(.white, lineWidth: 5)
                    .opacity(opacityValue)
            )
            .onAppear() {
                withAnimation(.easeInOut(duration: 0.5).repeatForever()) {
                    opacityValue = 1
                }
            }
            .onDisappear(){
                opacityValue = 0.2
            }
    }
}

struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
            .previewDisplayName("Default")
        CategoryHome()
            .previewDisplayName("iPhone SE")
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
    }
}


