//
//  SuccessView.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 16.12.2023.
//

import SwiftUI

// Экран успешного бронирования
struct SuccessView: View {
    @ObservedObject var viewModel: SuccessViewModel
    
    var body: some View {
        VStack(spacing: 57) {
            // Верхний отступ
            Spacer()
            
            // Графический элемент иконки и сообщения об успешном бронировании
            ZStack {
                Circle()
                    .frame(width: 94, height: 94)
                    .foregroundStyle(.customGray)
                Image(asset: .partyPopper)
                    .resizable()
                    .frame(width: 44, height: 44)
            }
            
            // Заголовок и описание успешного бронирования
            VStack(spacing: 20) {
                Text(Constants.orderIsAccepted)
                    .font(Font.Medium.m22)
                    .foregroundStyle(.black)
                Text(Constants.confirmation)
                    .multilineTextAlignment(.center)
                    .font(Font.Default.d16)
                    .foregroundStyle(.customDarkGray)
            }
            // Нижний отступ
            Spacer()
            
            // Кнопка для возвращения на главный экран
            ZStack {
                PrimaryButton(
                    title: Constants.superButtonTitle,
                    action: { viewModel.backToRootScreen() }
                )
            }
        }
        .padding(.horizontal, 16)
    }
}
