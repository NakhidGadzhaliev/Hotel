//
//  FailedView.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 18.12.2023.
//

import SwiftUI

struct FailView: View {
    var body: some View {
        VStack(spacing: 57) {
            Spacer()
            ZStack {
                Circle()
                    .frame(width: 94, height: 94)
                    .foregroundStyle(.customGray)
                Image(systemSymbol: .networkSlash)
                    .resizable()
                    .frame(width: 44, height: 44)
            }
            VStack(spacing: 20) {
                Text("Нет подключения к сети")
                    .font(Font.Medium.m22)
                    .foregroundStyle(.black)
                Text("Пожалуйста, попробуйте перезагрузить приложение")
                    .multilineTextAlignment(.center)
                    .font(Font.Default.d16)
                    .foregroundStyle(.customDarkGray)
            }
            Spacer()
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    FailView()
}
