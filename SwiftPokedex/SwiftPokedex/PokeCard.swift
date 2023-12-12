//
//  PokeCard.swift
//  SwiftPokedex
//
//  Created by Thales Gelinger on 09/12/23.
//

import SwiftUI

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
