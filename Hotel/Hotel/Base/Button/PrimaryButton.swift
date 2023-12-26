//
//  PrimaryButton.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 15.12.2023.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: Closure.Void
    
    var body: some View {
        Button(action: action, label: {
            Text(title)
                .padding(.vertical, 15)
                .frame(maxWidth: .infinity)
                .font(Font.Medium.m16)
        })
        .background(
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(Color.primaryButtonBlue)
        )
        .frame(height: 48)
        .foregroundStyle(.white)
    }
}
