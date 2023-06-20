//
//  CapsuleImageView.swift
//  Moonshot
//
//  Created by Joey Rideout on 2023-06-19.
//

import SwiftUI

struct CapsuleImageView: View {
    let image: String
    let header: String
    let subheader: String
    
    var body: some View {
        HStack {
            Image(image)
                .resizable()
                .frame(width: 104, height: 72)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .strokeBorder(.white, lineWidth: 1)
                )
            VStack(alignment: .leading) {
                Text(header)
                    .foregroundColor(.white)
                    .font(.headline)
                
                Text(subheader)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal)
    }
}

struct CapsuleImageView_Previews: PreviewProvider {
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        CapsuleImageView(image: "aldrin", header: "Example Name", subheader: "Example details")
            .preferredColorScheme(.dark)
    }
}
