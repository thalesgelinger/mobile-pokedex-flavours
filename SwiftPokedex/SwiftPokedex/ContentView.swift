//
//  ContentView.swift
//  SwiftPokedex
//
//  Created by Thales Gelinger on 01/11/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var searchTerm: String = "";
    
    private let data = (1...20).map { "\($0)" };
    
    var body: some View {
        ZStack {
            Color("Primary")
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack (alignment: .center, spacing: 16) {
                    Image(uiImage: .pokeball)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color("White"))
                        .frame(width: 24, height: 24)
                    
                    Text("Pokedex")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .font(Font.system(size: 24))
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color("White"))
                        .frame(height: 32)
                    
                    HStack (alignment: .center, spacing: 8)  {
                        Image(uiImage: .search)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color("Primary"))
                            .frame(width: 24, height: 24)
                        
                        TextField("Search", text: $searchTerm)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                ZStack {
                    ScrollView {
                        LazyVGrid(columns: (1...3).map { _ in GridItem() }, spacing: 20){
                            ForEach(data, id: \.self){
                                item in PokeCard(item: item)
                            }
                            .padding(.top, 24)
                            .padding(.horizontal, 12)
                        }
                    }
                }
                .background(.white)
                .cornerRadius(8)
                .padding(.horizontal, 4)
                .padding(.top, 24)
                .edgesIgnoringSafeArea(.bottom)
                .scrollIndicators(.hidden)
            }
        }
    }
    
}
struct PokeCard: View {
    var item = "";
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Rectangle()
                    .frame(height: 104/2)
                    .foregroundColor(Color("Background"))
                    .cornerRadius(8)
            }
            VStack {
                HStack {
                    Spacer()
                    Text("#\(item)")
                        .font(Font.custom("Poppins", size: 12))
                        .foregroundColor(.medium)
                }
                .padding(.horizontal, 8)
                .padding(.top, 4)
                
                GeometryReader { geometry in
                      AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")) { phase in
                          switch phase {
                          case .empty:
                              ProgressView()
                          case .success(let image):
                              image
                                  .resizable()
                                  .aspectRatio(contentMode: .fit)
                                  .frame(width: geometry.size.width, height: geometry.size.height)
                          case .failure:
                              Text("Failed to load image")
                          @unknown default:
                              EmptyView()
                          }
                      }
                  }
                
                Text("Bulbassaur")
                    .font(Font.custom("Poppins", size: 10))
                    .foregroundColor(.darkbg)
            }
            .frame(width: 104, height: 108)
        }
        .frame(width: 104, height: 108)
        .background(.white)
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.2), radius: 1.5, x: 0, y: 1)
    }
}
