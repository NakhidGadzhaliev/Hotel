//
//  AdvantagesView.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 16.12.2023.
//

import SwiftUI

struct AdvantagesView: View {
    let peculiarities: [String]
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(peculiarities, id: \.self) { item in
                Text(item)
                    .font(Font.Medium.m16)
                    .foregroundColor(Color.customDarkGray)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.customLightGray)
                    .cornerRadius(5)
                    .lineLimit(1)
            }
        }
    }
}

#Preview {
    AdvantagesView(peculiarities: ["ssdhgjdssdgsdkshghk", "sajdsh", "asf", "gjdshkghsdjgs", "ssdhgjdssdgsdkshghk", "sajdsh", "asf", "gjdshkghsdjgs"])
}
