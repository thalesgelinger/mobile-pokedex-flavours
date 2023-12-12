//
//  SearchBar.swift
//  SwiftPokedex
//
//  Created by Thales Gelinger on 09/12/23.
//

import SwiftUI

struct SearchBar: View {
    var body: some View {
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
    }
    
}
