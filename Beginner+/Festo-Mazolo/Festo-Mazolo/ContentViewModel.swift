//
//  ContentViewModel.swift
//  Festo-Mazolo
//
//  Created by Gergő on 11/04/2024.
//

import Foundation
import Combine
import UIKit

class ContentViewModel: ObservableObject {
    @Published var DataList: [WallHole] {
            didSet {
                saveDataList()
            }
    }

    init() {
        self.DataList = []
        self.DataList = loadDataList()
    }

    private let dataListKey = "DataList"
    
    private func saveDataList() {
        do {
            let data = try JSONEncoder().encode(DataList)
            UserDefaults.standard.set(data, forKey: dataListKey)
        } catch {
            print("Error saving data list: \(error)")
        }
    }

    private func loadDataList() -> [WallHole] {
        guard let data = UserDefaults.standard.data(forKey: dataListKey) else {
            return []
        }

        do {
            let dataList = try JSONDecoder().decode([WallHole].self, from: data)
            return dataList
        } catch {
            print("Error loading data list: \(error)")
            return []
        }
    }
    
    @Published var totalSurface: Double = 0
}
