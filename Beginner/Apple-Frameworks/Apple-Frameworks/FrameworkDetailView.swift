//
//  FrameworkDetailView.swift
//  Apple-Frameworks
//
//  Created by Gergő on 09/04/2024.
//

import SwiftUI

struct FrameworkDetailView: View {
    
    var framework: Framework
    @Binding var isShowingDetailView: Bool
    
    var body: some View {
        VStack {
            FrameworkTitleView(framework: framework, alignment: .center)
            Spacer()
            Text(framework.description)
                .font(.body)
                .padding()
            Spacer()
            Button{
                UIApplication.shared.open((URL(string: framework.urlString)!))
            }label: {
                AFButton(title: "Learn more")
            }
            Spacer()
        }
    }
}

#Preview {
    FrameworkDetailView(framework: MockData.sampleFramework, isShowingDetailView: .constant(false))
}


