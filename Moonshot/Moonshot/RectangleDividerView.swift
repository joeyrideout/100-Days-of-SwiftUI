//
//  RectangleDividerView.swift
//  Moonshot
//
//  Created by Joey Rideout on 2023-06-19.
//

import SwiftUI

struct RectangleDividerView: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.lightBackground)
            .padding(.vertical)
    }
}

struct RectangleDividerView_Previews: PreviewProvider {
    static var previews: some View {
        RectangleDividerView()
            .preferredColorScheme(.dark)
    }
}
