//
//  SuccessView.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 16.12.2023.
//

import SwiftUI

struct SuccessView: View {
    @ObservedObject var viewModel: SuccessViewModel
    
    var body: some View {
        VStack(spacing: 57) {
            Spacer()
            ZStack {
                Circle()
                    .frame(width: 94, height: 94)
                    .foregroundStyle(.customGray)
                Image(asset: .partyPopper)
                    .resizable()
                    .frame(width: 44, height: 44)
            }
            VStack(spacing: 20) {
                Text("Ваш заказ принят в работу")
                    .font(Font.Medium.m22)
                    .foregroundStyle(.black)
                Text("Подтверждение заказа №104893 может занять некоторое время (от 1 часа до суток). \n Как только мы получим ответ от туроператора, вам на почту придет уведомление.")
                    .multilineTextAlignment(.center)
                    .font(Font.Default.d16)
                    .foregroundStyle(.customDarkGray)
            }
            Spacer()
            ZStack {
                PrimaryButton(
                    title: "Супер!",
                    action: { viewModel.backToRootScreen() }
                )
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    SuccessView(
        viewModel: SuccessViewModel(
            coordinator: SuccessCoordinator()
        )
    )
}
