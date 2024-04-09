//
//  FrameworkGridView.swift
//  Apple-Frameworks
//
//  Created by Gergő on 09/04/2024.
//

import SwiftUI

struct FrameworkGridView: View {
    
    @StateObject var viewModel = FrameworkGridViewModel()
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(MockData.frameworks) { framework in
                    NavigationLink(destination: FrameworkDetailView(framework: framework, isShowingDetailView: $viewModel.isShowingDetailView)) {
                        FrameworkTitleView(framework: framework, alignment: .leading)
                    }
                }
            }
            .navigationTitle("🍏 Frameworks")
        }
    }
}

#Preview {
    FrameworkGridView()
}

struct FrameworkTitleView: View {
    let framework: Framework
    let alignment: HorizontalAlignment
    
    var body: some View {
        VStack(alignment: alignment) {
            Image(framework.imageName)
                .resizable()
                .frame(width: 60, height: 60)
            Text(framework.name)
                .font(.title2)
                .fontWeight(.semibold)
                .scaledToFit()
                .minimumScaleFactor(0.5)
        }
        .padding()
    }
}
