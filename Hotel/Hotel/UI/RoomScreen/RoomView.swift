//
//  RoomView.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 15.12.2023.
//

import SwiftUI

// Экран с информацией о номерах в отеле
struct RoomView: View {
    @ObservedObject var viewModel: RoomViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Отображение индикатора загрузки при загрузке данных
            if viewModel.isLoading {
                ProgressView(Constants.pageLoading)
            } else if let _ = viewModel.error {
                // Отображение экрана ошибки при неудачной загрузке
                FailView()
            } else {
                // Отображение списка номеров отеля
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 8) {
                        ForEach(viewModel.room.rooms, id: \.id) { room in
                            // Отображение элемента комнаты
                            RoomItemView(
                                room: room,
                                onButtonTap: viewModel.openNextScreen
                            )
                        }
                    }
                    .padding(.top, 8)
                    .background(Color.customGray)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .onAppear {
            // Запрос данных о номерах при появлении экрана
            viewModel.fetchRoom()
        }
    }
}

// Представление для отображения информации о номере
private struct RoomItemView: View {
    let room: RoomElement
    let onButtonTap: Closure.Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Слайдер с изображениями номера
            ImageSlider(imageUrls: room.imageUrls)
            
            // Название номера
            Text(room.name)
                .font(Font.Medium.m22)
                .foregroundStyle(.black)
            
            // Особенности номера
            PeculiaritiesView(peculiarities: room.peculiarities)
            
            // Кнопка для получения дополнительной информации о номере (временно отключена)
            Button(action: {
                // Действие при нажатии на кнопку (пока не определено)
            }, label: {
                HStack(spacing: 2) {
                    Text(Constants.detailsAboutRoom)
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
            
            // Цена за проживание
            Text("\(room.price) \(String.currency) ")
                .font(Font.Semibold.s30)
                .foregroundStyle(.black)
            +
            // Дополнительная информация о цене
            Text(room.pricePer.lowercased())
                .foregroundStyle(Color.customDarkGray)
                .font(Font.Default.d16)
            
            // Кнопка для выбора номера
            PrimaryButton(
                title: Constants.chooseRoom,
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
