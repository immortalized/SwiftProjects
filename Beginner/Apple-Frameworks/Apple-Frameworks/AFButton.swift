//
//  AFButton.swift
//  Apple-Frameworks
//
//  Created by Gergő on 09/04/2024.
//

import SwiftUI

struct AFButton: View {
    
    let title: String
    
    var body: some View {
        Text(title)
            .foregroundColor(.white)
            .fontWeight(.semibold)
            .frame(width: 280, height: 50)
            .background(.red)
            .cornerRadius(10)
    }
}
