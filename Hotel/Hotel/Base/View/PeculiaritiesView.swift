//
//  PeculiaritiesView.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 16.12.2023.
//

import SwiftUI

struct PeculiaritiesView: View {
    let peculiarities: [String]
    
    var body: some View {
        TagsLayout {
            ForEach(peculiarities, id: \.self) { item in
                Text(item)
                    .font(Font.Medium.m16)
                    .foregroundColor(Color.customDarkGray)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.customLightGray)
                    .cornerRadius(5)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .frame(height: 29)
            }
            .padding(.leading, 16)
        }
    }
}
