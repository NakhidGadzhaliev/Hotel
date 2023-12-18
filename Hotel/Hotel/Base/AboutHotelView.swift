//
//  AboutHotelView.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 15.12.2023.
//

import SwiftUI

struct AboutHotelView: View {
    let name: String
    let address: String
    let rating: Int
    let ratingName: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            RatingView(rating: rating, ratingName: ratingName)

            Text(name)
                .font(Font.Medium.m16)
                .foregroundStyle(.black)

            Button(action: {}, label: {
                Text(address)
                    .font(Font.Medium.m14)
                    .foregroundColor(Color.customBlue)
            })
            .disabled(true)
        }
    }
}

private struct RatingView: View {
    let rating: Int
    let ratingName: String
    
    var body: some View {
        HStack(spacing: 2) {
            Image(systemSymbol: .starFill)
            Text("\(rating)")
            Text(ratingName)
        }
        .font(Font.Medium.m16)
        .foregroundColor(Color.customOrange)
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(Color.customYellow)
        .cornerRadius(5)
    }
}

#Preview {
    AboutHotelView(name: "safd", address: "afdsf", rating: 5, ratingName: "dhgjsdkg")
}
