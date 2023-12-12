//
//  Extensions.swift
//  SwiftPokedex
//
//  Created by Thales Gelinger on 11/12/23.
//

import SwiftUI

extension String {
    func padStart(_ length: Int, _ pad: String)-> String {
        return String(String(self.reversed()).padding(toLength: length, withPad: pad, startingAt: 0).reversed())
    }
    
    func capitalizeFirstLetter() -> String {
        guard let first = first else { return self }
        return String(first).uppercased() + dropFirst().lowercased()
    }
    
}

extension View {
    func pill(_ color:Color) -> some View {
        modifier(Pill(color: color))
    }
}
