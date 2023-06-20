//
//  ForEachMissionView.swift
//  Moonshot
//
//  Created by Joey Rideout on 2023-06-19.
//

import SwiftUI

struct ForEachMissionView: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    let listViewEnabled: Bool
    
    var body: some View {
        ForEach(missions) { mission in
            NavigationLink {
                MissionView(mission: mission, astronauts: astronauts)
            } label: {
                VStack {
                    if !listViewEnabled {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding()
                    }
                    HStack {
                        if listViewEnabled {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .padding(.trailing)
                        }
                        VStack {
                            Text(mission.displayName)
                                .font(listViewEnabled  ? .title2 : .headline)
                                .foregroundColor(.white)
                            Text(mission.formattedLaunchDate)
                                .font(listViewEnabled ? .subheadline : .caption)
                                .foregroundColor(.white.opacity(0.5))
                        }
                    }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(.lightBackground)
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(.lightBackground))
            }
        }
    }
}

struct ForEachMissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        ForEachMissionView(missions: missions, astronauts: astronauts, listViewEnabled: true)
            .preferredColorScheme(.dark)
    }
}
