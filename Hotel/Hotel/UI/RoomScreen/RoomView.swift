//
//  RoomView.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 15.12.2023.
//

import SwiftUI

struct RoomView: View {
    @ObservedObject var viewModel: RoomViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if viewModel.isLoading {
                ProgressView("Page is loading")
            } else if let _ = viewModel.error {
                FailView()
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 8) {
                        ForEach(viewModel.room.rooms, id: \.id) { room in
                            RoomItemView(
                                room: room,
                                onButtonTap: viewModel.openNextScreen
                            )
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .background(Color.customGray)
            }
        }
        .onAppear {
            viewModel.fetchRoom()
        }
    }
}

private struct RoomItemView: View {
    let room: RoomElement
    let onButtonTap: Closure.Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ImageSlider(imageUrls: room.imageUrls)
            
            Text(room.name)
                .font(Font.Medium.m22)
                .foregroundStyle(.black)
            
            AdvantagesView(peculiarities: room.peculiarities)
            
            Button(action: {
                //
            }, label: {
                HStack(spacing: 2) {
                    Text("Подробнее о номере")
                    Image(systemSymbol: .chevronRight)
                }
                .font(Font.Medium.m16)
                .foregroundColor(Color.customBlue)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color.customLightBlue)
                .cornerRadius(5)
            })
            .disabled(true)
            
            Text("\(room.price) ₽ ")
                .font(Font.Semibold.s30)
                .foregroundStyle(.black)
            +
            Text(room.pricePer.lowercased())
                .foregroundStyle(Color.customDarkGray)
                .font(Font.Default.d16)
            
            PrimaryButton(
                title: "Выбрать номер",
                action: onButtonTap
            )
            
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.white)
        )
    }
}

#Preview {
    RoomView(
        viewModel: RoomViewModel(
            coordinator: RoomCoordinator(),
            networkManager: NetworkManager()
        )
    )
}
