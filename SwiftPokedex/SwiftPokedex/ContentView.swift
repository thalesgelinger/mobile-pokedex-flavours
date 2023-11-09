//
//  ContentView.swift
//  SwiftPokedex
//
//  Created by Thales Gelinger on 01/11/23.
//

import SwiftUI

struct BasePokeData : Codable {
    var name: String;
    var url: String;
}

struct PokemonsData : Codable {
    var results: [BasePokeData]
}

struct PokeData : Codable {
    var number: Int;
    var name: String;
    var imgUrl: String;
}

struct Sprites: Codable {
    var front_default: String;
}

struct PokeDetailsDataBase: Codable {
    var id: Int;
    var name: String;
    var sprites: Sprites
}

struct ContentView: View {
    
    @State private var searchTerm: String = "";
    @State private var pokemons: [PokeData] = [];
    
    func fetchPokemons() async {
        guard let pokemonsUrl = URL(string:"https://pokeapi.co/api/v2/pokemon?limit=50&offset=0") else {
           print("Error building url")
           return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: pokemonsUrl)
            let pokemonsData = try JSONDecoder().decode(PokemonsData.self, from: data)
            
            for poke in pokemonsData.results {
                guard let url = URL(string: poke.url) else {
                    print("Error creating url for poke details")
                    return
                }
                
                do {
                    let (response, _) = try await URLSession.shared.data(from: url)
                    let pokeDetails = try JSONDecoder().decode(PokeDetailsDataBase.self, from: response)
                    let pokeData = PokeData(number: pokeDetails.id, name: pokeDetails.name, imgUrl: pokeDetails.sprites.front_default);
                    pokemons.append(pokeData)
                } catch {
                    print("Error fetching details")
                }
            }
        } catch {
            print("Error fetching pokemons")
        }
    
    }
    
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
                            ForEach(pokemons, id: \.number){
                                poke in PokeCard(number: poke.number, imageUrl: poke.imgUrl, name: poke.name)
                            }
                            .padding(.top, 24)
                            .padding(.horizontal, 12)
                        }
                        .onAppear() {
                            Task {
                                await fetchPokemons()
                            }
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
    var number: Int;
    var imageUrl: String;
    var name: String;
    
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
                    Text("#\(number)")
                        .font(Font.custom("Poppins", size: 12))
                        .foregroundColor(.medium)
                }
                .padding(.horizontal, 8)
                .padding(.top, 4)
                
                GeometryReader { geometry in
                      AsyncImage(url: URL(string: imageUrl)) { phase in
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
                
                Text(name)
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
