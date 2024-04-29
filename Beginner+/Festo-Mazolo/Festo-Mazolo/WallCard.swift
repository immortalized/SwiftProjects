//
//  WallCard.swift
//  Festo-Mazolo
//
//  Created by Gergő on 11/04/2024.
//

import SwiftUI

struct WallCard: View {
    
    let dataWidth: Double
    let dataHeight: Double
    let dataName: String
    let imageSystemName: String
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: imageSystemName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 30)
            Spacer()
            VStack(spacing: 10) {
                Text("\(dataName) width: \(String(format: "%.2f", dataWidth))")
                Text("\(dataName) height: \(String(format: "%.2f", dataHeight))")
            }
            .font(.system(size: 14, weight: .semibold))
        }
        .padding(20)
    }
}

#Preview {
    WallCard(dataWidth: 20.2, dataHeight: 10.1, dataName: "Window", imageSystemName: "window.casement")
}
