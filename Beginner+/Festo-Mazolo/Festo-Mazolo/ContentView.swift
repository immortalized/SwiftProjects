//
//  ContentView.swift
//  Festo-Mazolo
//
//  Created by Gergő on 10/04/2024.
//

import SwiftUI


enum DataTypes {
    case wall, door, window
}

struct ContentView: View {
    
    @ObservedObject var viewModel = ContentViewModel()
    
    @FocusState var keyboardShown: Bool
    
    @State var dataWidth = ""
    @State var dataHeight = ""
    @State var dataType = DataTypes.wall
    
    let paintPricePerSqm = 2500
    let wallpaperPricePerSqm = 4000
    
    var body: some View {
        Spacer(minLength: 1)
        
        ScrollView {
            Text("Calculator")
                .font(.system(size: 30, weight: .semibold))
            
            List {
                Section {
                    ForEach(viewModel.DataList) { wallhole in
                        WallCard(dataWidth: wallhole.dataWidth, dataHeight: wallhole.dataHeight, dataName: wallhole.dataName, imageSystemName: wallhole.imageSystemName)
                    }
                    .onDelete(perform: delete)
                } header: {
                    Text("Walls, doors and windows")
                }
            }
            .frame(height: 225)
            .scrollContentBackground(.hidden)
            
            Form {
                Text("Add data")
                    .font(.system(size: 24, weight: .semibold))
                    .padding(.bottom, 16)
                
                TextField("Width", text: $dataWidth)
                    .keyboardType(.decimalPad)
                    .focused($keyboardShown)
                
                TextField("Height", text: $dataHeight)
                    .keyboardType(.decimalPad)
                    .focused($keyboardShown)
                
                Picker("Data type", selection: $dataType) {
                    Text("Wall").tag(DataTypes.wall)
                    Text("Door").tag(DataTypes.door)
                    Text("Window").tag(DataTypes.window)
                }
                
                HStack {
                    Spacer()
                    Button("Add", action: {
                        var width = Double(dataWidth.replacingOccurrences(of: ",", with: "."))
                        var height = Double(dataHeight.replacingOccurrences(of: ",", with: "."))
                        
                        if(width != nil || height != nil) {
                            AddData(dataWidth: width!,
                                    dataHeight: height!, dataType: dataType)
                        }
                    })
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(.green)
                    )
                }
                .padding(.vertical, 10)
            }
            .scrollDisabled(true)
            .scrollContentBackground(.hidden)
            .frame(height: 325)
            
            VStack (spacing: 8) {
                Text("Results")
                    .font(.system(size: 24, weight: .semibold))
                Text("Total surface: \(calcSurface(viewModel: viewModel) < 0 ? "Invalid input" : String(format: "%.2f m²", calcSurface(viewModel: viewModel)))")
                    .font(.system(size: 18, weight: .light))
                if calcSurface(viewModel: viewModel) > 0 {
                    Text("Price of painting: \(Int(calcSurface(viewModel: viewModel)) * paintPricePerSqm) HUF")
                        .font(.system(size: 16, weight: .light))
                        .opacity(0.7)
                    Text("Price of wallpapering: \(Int(calcSurface(viewModel: viewModel)) * wallpaperPricePerSqm) HUF")
                        .font(.system(size: 16, weight: .light))
                        .opacity(0.7)
                }
            }
        }
        .onTapGesture(count: keyboardShown ? 1 : .max, perform: {
            keyboardShown = false
        })
    }
    
    func delete(at offsets: IndexSet) {
        viewModel.DataList.remove(atOffsets: offsets)
    }
    
    func calcSurface(viewModel: ContentViewModel) -> Double {
        
        if viewModel.DataList.isEmpty {
            return 0
        }
        
        var totalSurface: Double = 0
        
        for wallhole in viewModel.DataList {
            let surface = wallhole.dataWidth * wallhole.dataHeight
            
            if wallhole.dataName == "Wall" {
                totalSurface += surface
            } else {
                totalSurface -= surface
            }
        }
        
        return totalSurface
    }
    
    func AddData(dataWidth: Double, dataHeight: Double, dataType: DataTypes) {
        
        var dataName: String
        var imageSystemName: String
        
        switch dataType {
        case DataTypes.door:
            dataName = "Door"
            imageSystemName = "door.left.hand.closed"
        case .wall:
            dataName = "Wall"
            imageSystemName = "rectangle.checkered"
        case .window:
            dataName = "Window"
            imageSystemName = "window.casement"
        }
        
        viewModel.DataList.append(
            WallHole(dataWidth: dataWidth, dataHeight: dataHeight, dataName: dataName, imageSystemName: imageSystemName)
        )
    }
}

#Preview {
    ContentView()
}
