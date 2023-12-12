//
//  DetailsView.swift
//  SwiftPokedex
//
//  Created by Thales Gelinger on 09/12/23.
//

import SwiftUI

struct PokeDetailsBase: Codable {
    var id: Int;
    var name: String;
    var sprites: Sprites;
    var weight: Int;
    var height: Int;
    var abilities: [Abilities];
    var types: [Types];
    var stats: [Stats]
    
}

struct Stats: Codable {
    var base_stat: Int;
    var stat: Stat
}

struct Stat: Codable {
    var name: String;
}

struct Types: Codable {
    var type: Type
}

struct Type: Codable {
    var name: String
}

struct Abilities: Codable {
    var ability: Ability
}

struct Ability: Codable {
    var name: String
}

struct PokeDetails: Codable {
    var name: String;
    var img: String;
    var weigth: Int;
    var heigth: Int;
    var abilities: [String];
    var types: [String];
    var stats: DetailsStats;
}

struct DetailsStats: Codable {
    var hp: Int
    var atk: Int
    var def: Int
    var satk: Int
    var sdef: Int
    var spd: Int
}

struct DetailsView: View {
    var pokeId: Int;
    
    @State var pokeData: PokeDetails?
    @State var pokeColor: Color = .black
    @Environment(\.dismiss) var goBack: DismissAction
    
    
    func fetchPokeDetails() async -> Void {
        let detailsUrl = "https://pokeapi.co/api/v2/pokemon/\(pokeId)/"
        
        guard let url = URL(string: detailsUrl) else {
            print("Error creating url for poke details")
            return
        }
        
        do {
            let (response, _) = try await URLSession.shared.data(from: url)
            let pokeDetails = try JSONDecoder().decode(PokeDetailsBase.self, from: response)
            let stats = DetailsStats (
                hp: pokeDetails.stats[0].base_stat,
                atk: pokeDetails.stats[1].base_stat,
                def: pokeDetails.stats[2].base_stat,
                satk: pokeDetails.stats[3].base_stat,
                sdef: pokeDetails.stats[4].base_stat,
                spd:  pokeDetails.stats[5].base_stat
            )
            pokeData = PokeDetails(
                name: pokeDetails.name ,
                img: pokeDetails.sprites.front_default,
                weigth: pokeDetails.weight,
                heigth: pokeDetails.height,
                abilities: pokeDetails.abilities.map { ability in ability.ability.name },
                types: pokeDetails.types.map { type in type.type.name},
                stats: stats
            )
            pokeColor = Color(UIColor(named: pokeData!.types[0].capitalizeFirstLetter())!)
            
        } catch {
            print("Error fetching details")
        }
    }
    
    func statPercentage(_ stat: Int) -> Float {
        let percentage =  Float(stat)/255
        
        return percentage
    }
    
    var body: some View {
        NavigationView {
            if pokeData == nil {
                ProgressView("Loading Pokemon Details")
            } else {
                
                ZStack (alignment:.topTrailing) {
                    Color(pokeColor)
                        .edgesIgnoringSafeArea(.all)
                    Image(uiImage: .pokeball)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color("White"))
                        .opacity(0.4)
                        .frame(width: 200, height: 200)
                    
                    HStack {
                        NavigationLink (destination: DetailsView(pokeId: pokeId - 1)) {
                            Image(uiImage: .chevronLeft)
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(Color("White"))
                                .frame(width: 32, height: 32)
                            
                        }
                        Spacer()
                        GeometryReader { geometry in
                            AsyncImage(url: URL(string: pokeData!.img)) { phase in
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
                        Spacer()
                        NavigationLink (destination: DetailsView(pokeId: pokeId + 1)) {
                            Image(uiImage: .chevronRight)
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(Color("White"))
                                .frame(width: 32, height: 32)
                        }
                    }
                    .frame(height: 200)
                    .offset(x:0, y: 100)
                    
                    VStack {
                        HStack {
                            Image(uiImage: .arrowBack)
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(Color("White"))
                                .frame(width: 32, height: 32)
                                .onTapGesture {
                                    goBack()
                                }
                            Text(pokeData!.name)
                                .foregroundColor(.white)
                                .bold()
                            Spacer()
                            Text("#\(String(pokeId).padStart(3, "0"))")
                                .foregroundColor(.white)
                        }
                        .padding(20)
                        .padding(.bottom, 200)
                        
                        
                        ZStack {
                            Color(.white)
                                .edgesIgnoringSafeArea(.all)
                            VStack {
                                Spacer()
                                
                                HStack {
                                    ForEach (pokeData!.types, id: \.self){
                                        type in 
                                        let typeColor: Color = Color(UIColor(named: type.capitalizeFirstLetter())!)
                                        Text(type).pill(typeColor)
                                    }
                                }
                                
                                Text("About")
                                    .foregroundColor(pokeColor)
                                    .bold()
                                    .padding(.vertical, 16)
                                
                                
                                HStack {
                                    Spacer()
                                    VStack {
                                        HStack {
                                            Image(uiImage: .weight)
                                                .resizable()
                                                .renderingMode(.template)
                                                .foregroundColor(.black)
                                                .frame(width: 16, height: 16)
                                            Text("\(pokeData!.weigth) kg")
                                                .font(.system(size: 10))
                                                .foregroundColor(.black)
                                        }
                                        .padding(.vertical, 8)
                                        Text("Weight")
                                            .font(Font.custom("Poppins", size: 8))
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                    
                                    Divider()
                                        .frame(height: 48)
                                    
                                    Spacer()
                                    VStack {
                                        HStack {
                                            Image(uiImage: .straighten)
                                                .resizable()
                                                .renderingMode(.template)
                                                .foregroundColor(.black)
                                                .frame(width: 16, height: 16)
                                                .rotationEffect(.degrees(90))
                                            Text("\(pokeData!.heigth)m")
                                                .font(.system(size: 10))
                                                .foregroundColor(.black)
                                        }
                                        .padding(.vertical, 8)
                                        Text("Height")
                                            .font(Font.custom("Poppins", size: 8))
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                    
                                    Divider()
                                        .frame(height: 48)
                                    
                                    Spacer()
                                    VStack {
                                        VStack {
                                            ForEach (pokeData!.abilities, id: \.self){
                                                ability in
                                                Text(ability)
                                                    .font(.system(size: 10))
                                                    .foregroundColor(.black)
                                            }
                                        }
                                        .padding(.vertical, 8)
                                        Text("Weight")
                                            .font(Font.custom("Poppins", size: 8))
                                            .foregroundColor(.gray)
                                    }
                                    
                                    Spacer()
                                }
                                
                                
                                Text("There is a plant seed on its back right from the day this Pokémon is born. The seed slowly grows larger.")
                                    .font(Font.custom("Poppins", size: 10))
                                    .foregroundColor(.black)
                                    .padding(.vertical, 16)
                                
                                Text("Base Stats")
                                    .foregroundColor(pokeColor)
                                    .bold()
                                    .padding(.vertical, 16)
                                
                                HStack {
                                    
                                    VStack (alignment: .trailing, spacing: 8) {
                                        Text("HP")
                                        Text("ATK")
                                        Text("DEF")
                                        Text("SATK")
                                        Text("SDEF")
                                        Text("SPD")
                                    }
                                    .foregroundColor(pokeColor)
                                    .bold()
                                    
                                    Divider()
                                    VStack (spacing: 8){
                                        Text(String(pokeData!.stats.hp).padStart(3, "0"))
                                        Text(String(pokeData!.stats.atk).padStart(3, "0"))
                                        Text(String(pokeData!.stats.def).padStart(3, "0"))
                                        Text(String(pokeData!.stats.satk).padStart(3, "0"))
                                        Text(String(pokeData!.stats.sdef).padStart(3, "0"))
                                        Text(String(pokeData!.stats.spd).padStart(3, "0"))
                                    }
                                    
                                    VStack (spacing: 24) {
                                        ProgressView(value: statPercentage(pokeData!.stats.hp))
                                            .background(pokeColor.opacity(0.2))
                                        ProgressView(value: statPercentage(pokeData!.stats.atk))
                                            .background(pokeColor.opacity(0.2))
                                        ProgressView(value: statPercentage(pokeData!.stats.def))
                                            .background(pokeColor.opacity(0.2))
                                        ProgressView(value: statPercentage(pokeData!.stats.satk))
                                            .background(pokeColor.opacity(0.2))
                                        ProgressView(value: statPercentage(pokeData!.stats.sdef))
                                            .background(pokeColor.opacity(0.2))
                                        ProgressView(value: statPercentage(pokeData!.stats.spd))
                                            .background(pokeColor.opacity(0.2))
                                    }
                                    .tint(pokeColor)
                                }
                                .frame(maxHeight: 160)
                                Spacer()
                            }
                            .padding(.horizontal, 20)
                            
                        }
                        .cornerRadius(8)
                        .padding(4)
                    }
                    
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            Task {
                await fetchPokeDetails()
            }
        }
    }
}


struct Pill : ViewModifier {
    var color: Color
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 8)
            .padding(.vertical, 2)
            .foregroundColor(.white)
            .background(color)
            .cornerRadius(10)
    }
}

struct DetailsView_Previews: PreviewProvider{
    static var previews: some View {
        DetailsView(pokeId: 1)
    }
}
