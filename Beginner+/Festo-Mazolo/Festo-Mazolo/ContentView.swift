//
//  ContentView.swift
//  Festo-Mazolo
//
//  Created by Gergő on 10/04/2024.
//

import SwiftUI


enum DataTypes {
    case wall, door, window, ceiling
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
                .font(.system(size: 28, weight: .semibold))
            
            List {
                Section {
                    ForEach(viewModel.DataList) { wallhole in
                        WallCard(dataWidth: wallhole.dataWidth, dataHeight: wallhole.dataHeight, dataName: wallhole.dataName, imageSystemName: wallhole.imageSystemName)
                    }
                    .onDelete(perform: delete)
                } header: {
                    HStack {
                        Text("Walls, doors and windows")
                        Spacer()
                        Button(action: {
                            viewModel.DataList.removeAll()
                        }, label: {
                            HStack {
                                Image(systemName: "xmark.circle")
                                    .resizable()
                                    .frame(width: 12, height: 12)
                                Text("Clear")
                                    .font(.system(size: 12))
                            }
                            .foregroundStyle(.red)
                        })
                    }
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
                    Text("Ceiling").tag(DataTypes.ceiling)
                }
                
                HStack {
                    Spacer()
                    Button("Add", action: {
                        let width = Double(dataWidth.replacingOccurrences(of: ",", with: "."))
                        let height = Double(dataHeight.replacingOccurrences(of: ",", with: "."))
                        
                        if (width != nil || height != nil) {
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
                let totalSurface = calcSurface(viewModel: viewModel, isWallpaper: false)
                Text("Total surface: \(totalSurface < 0 ? "Invalid input" : String(format: "%.2f m²", totalSurface))")
                    .font(.system(size: 18, weight: .light))
                let surfacePaint = calcSurface(viewModel: viewModel, isWallpaper: false)
                let surfaceWallpaper = calcSurface(viewModel: viewModel, isWallpaper: true)
                
                if (surfacePaint > 0) {
                    Text("Price of painting: \(Int(surfacePaint * Double(paintPricePerSqm))) HUF")
                        .font(.system(size: 16, weight: .light))
                        .opacity(0.7)
                }
                if(surfaceWallpaper > 0) {
                    Text("Price of wallpapering: \(Int(surfaceWallpaper * Double(wallpaperPricePerSqm))) HUF")
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
    
    func calcSurface(viewModel: ContentViewModel, isWallpaper: Bool) -> Double {
        
        if viewModel.DataList.isEmpty {
            return 0
        }
        
        var totalSurface: Double = 0
        
        for wallhole in viewModel.DataList {
            let surface = wallhole.dataWidth * wallhole.dataHeight
            
            if (wallhole.dataName == "Wall") {
                totalSurface += surface
            } else if (wallhole.dataName == "Ceiling" && !isWallpaper) {
                totalSurface += surface
            }
            else if (wallhole.dataName != "Ceiling") {
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
            case .ceiling:
                dataName = "Ceiling"
                imageSystemName = "fan.ceiling.fill"
        }
        
        viewModel.DataList.append(
            WallHole(dataWidth: dataWidth, dataHeight: dataHeight, dataName: dataName, imageSystemName: imageSystemName)
        )
    }
}

#Preview {
    ContentView()
}
