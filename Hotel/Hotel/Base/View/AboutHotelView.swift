//
//  AboutHotelView.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 15.12.2023.
//

import SwiftUI

// Отображение информации об отеле, включая рейтинг и адрес
struct AboutHotelView: View {
    let name: String
    let address: String
    let rating: Int
    let ratingName: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Отображение рейтинга отеля
            RatingView(rating: rating, ratingName: ratingName)
            
            // Отображение названия отеля
            Text(name)
                .font(Font.Medium.m16)
                .foregroundStyle(.black)
            
            // Кнопка с адресом отеля (в данном случае неактивная)
            Button(action: {}, label: {
                Text(address)
                    .font(Font.Medium.m14)
                    .foregroundColor(Color.customBlue)
            })
            .disabled(true)
        }
    }
}

// Отображение рейтинга с иконкой звезды, числовым значением и наименованием рейтинга
private struct RatingView: View {
    let rating: Int
    let ratingName: String
    
    var body: some View {
        HStack(spacing: 2) {
            // Иконка звезды
            Image(systemSymbol: .starFill)
            // Числовое значение рейтинга
            Text("\(rating)")
            // Наименование рейтинга
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
