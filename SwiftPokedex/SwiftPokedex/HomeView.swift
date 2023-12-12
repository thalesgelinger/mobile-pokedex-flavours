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

struct PokeData : Hashable {
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

struct HomeView: View {
    
    @State private var searchTerm: String = "";
    @State private var pokemons: [PokeData] = [];
    
    @State private var path = NavigationPath()
    
    private var transaction: Transaction {
        var t = Transaction()
        t.disablesAnimations = true
        return t
    }
    
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
        NavigationStack (path: $path.transaction(transaction)) {
            ZStack {
                Color("Primary")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    SearchBar()
                    
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
                                .foregroundColor(.black)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                    
                    ZStack {
                        ScrollView {
                            LazyVGrid(columns: (1...3).map { _ in GridItem() }, spacing: 20){
                                ForEach(pokemons.filter {p in p.name.hasPrefix(searchTerm.lowercased())}, id: \.number){
                                    poke in NavigationLink (value: poke.number) {
                                        PokeCard(number: poke.number, imageUrl: poke.imgUrl, name: poke.name)
                                    }
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
            .navigationDestination(for: Int.self) { pokeId in
                DetailsView(pokeId: pokeId, path: $path)
            }
        }
    }
}
