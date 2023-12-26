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
                Text(Constants.orderIsAccepted)
                    .font(Font.Medium.m22)
                    .foregroundStyle(.black)
                Text(Constants.confirmation)
                    .multilineTextAlignment(.center)
                    .font(Font.Default.d16)
                    .foregroundStyle(.customDarkGray)
            }
            Spacer()
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
