//
//  ContentView.swift
//  Moonshot
//
//  Created by Joey Rideout on 2023-06-17.
//

import SwiftUI

struct ContentView: View {
    @State private var listViewEnabled = false
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                if listViewEnabled {
                    ForEachMissionView(missions: missions, astronauts: astronauts, listViewEnabled: listViewEnabled)
                } else {
                    LazyVGrid(columns: columns) {
                        ForEachMissionView(missions: missions, astronauts: astronauts, listViewEnabled: listViewEnabled)
                    }
                    .padding([.horizontal, .bottom])
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button(listViewEnabled ? "Grid" : "List") {
                    listViewEnabled.toggle()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
