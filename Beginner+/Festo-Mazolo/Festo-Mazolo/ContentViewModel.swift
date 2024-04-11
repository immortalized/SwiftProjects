//
//  ContentViewModel.swift
//  Festo-Mazolo
//
//  Created by Gergő on 11/04/2024.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    @Published var DataList = [WallHole]()
    @Published var totalSurface: Double = 0
}
