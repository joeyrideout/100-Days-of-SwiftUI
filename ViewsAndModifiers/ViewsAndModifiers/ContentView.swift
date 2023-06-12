//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Joey Rideout on 2023-06-11.
//

import SwiftUI

struct Prominant: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.weight(.semibold))
            .foregroundColor(.blue)
    }
}

extension View {
    func styleProminant() -> some View {
        modifier(Prominant())
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
                .styleProminant()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
