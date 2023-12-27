//
//  HotelView.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 14.12.2023.
//

import SwiftUI

struct HotelView: View {
    @ObservedObject var viewModel: HotelViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if viewModel.isLoading {
                // Показывать индикатор загрузки, если данные загружаются
                ProgressView(Constants.pageLoading)
            } else if let _ = viewModel.error {
                // Показывать экран ошибки, если загрузка завершилась с ошибкой
                FailView()
            } else {
                // Показывать основной интерфейс с данными отеля
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 8) {
                        // Верхняя часть с изображением, рейтингом и основной информацией
                        VStack(alignment: .leading, spacing: 16) {
                            ImageSlider(imageUrls: viewModel.hotel.imageUrls)
                            MainInfoView(
                                rating: viewModel.hotel.rating,
                                ratingName: viewModel.hotel.ratingName,
                                name: viewModel.hotel.name,
                                address: viewModel.hotel.adress,
                                price: viewModel.hotel.minimalPrice,
                                priceForIt: viewModel.hotel.priceForIt
                            )
                        }
                        .padding(16)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundStyle(.white)
                        )
                        
                        // Детальная информация об отеле
                        DetailInfoView(
                            peculiarities: viewModel.hotel.aboutTheHotel.peculiarities,
                            description: viewModel.hotel.aboutTheHotel.description
                        )
                    }
                    .padding(.bottom, 12)
                    .background(Color.customGray)
                }
                .padding(.bottom, 60)
                
                // Кнопка для перехода к выбору номера
                ZStack {
                    PrimaryButton(
                        title: Constants.chooseNumber,
                        action: { viewModel.openRoomScreen(with: viewModel.hotel.name) }
                    )
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                }
                .background(Color.white)
            }
        }
        .onAppear {
            // Загружать данные об отеле при появлении экрана
            viewModel.fetchHotel()
        }
    }
}

// Детальная информация об отеле
private struct DetailInfoView: View {
    let peculiarities: [String]
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Заголовок "О гостинице"
            Text(Constants.aboutHotel)
                .font(Font.Medium.m22)
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 16)
            
            // Особенности гостиницы
            PeculiaritiesView(peculiarities: peculiarities)
                .padding(.bottom, 12)
            
            // Описание гостиницы
            Text(description)
                .font(Font.Default.d16)
                .foregroundStyle(.black.opacity(0.9))
                .padding(.bottom, 16)
            
            // Дополнительная информация
            AdditionalInfoView()
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.white)
                .ignoresSafeArea()
        )
    }
}

// Вид для дополнительной информации
private struct AdditionalInfoView: View {
    var body: some View {
        VStack(spacing: 0) {
            // Элементы дополнительной информации
            AdditionalInfoItemView(
                icon: Image(asset: .emojiHappy),
                title: Constants.facilities,
                description: Constants.essentials
            )
            Divider()
                .background(Color.customDarkGray)
                .padding(.trailing, 31)
                .padding(.leading, 69)
            AdditionalInfoItemView(
                icon: Image(asset: .tickSquare),
                title: Constants.included,
                description: Constants.essentials
            )
            Divider()
                .background(Color.customDarkGray)
                .padding(.trailing, 31)
                .padding(.leading, 69)
            AdditionalInfoItemView(
                icon: Image(asset: .closeSquare),
                title: Constants.notIncluded,
                description: Constants.essentials
            )
        }
    }
}

// Элемент дополнительной информации
private struct AdditionalInfoItemView: View {
    let icon: Image
    let title: String
    let description: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            // Фон элемента
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(.customLightGray)
            // Содержимое элемента
            HStack(alignment: .center, spacing: 12) {
                icon
                    .resizable()
                    .frame(width: 24, height: 24)
                VStack(alignment: .leading, spacing: 2) {
                    // Заголовок и описание элемента
                    Text(title)
                        .font(Font.Medium.m16)
                        .foregroundStyle(.black)
                    Text(description)
                        .font(Font.Medium.m14)
                        .foregroundStyle(.customDarkGray)
                }
                Spacer()
                // Стрелка вправо для указания возможности перехода
                Image(systemSymbol: .chevronRight)
            }
            .padding(.horizontal, 31)
            .padding(.vertical, 15)
        }
    }
}

// Главная информация об отеле
private struct MainInfoView: View {
    let rating: Int
    let ratingName: String
    let name: String
    let address: String
    let price: Int
    let priceForIt: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Вид с информацией о гостинице (название, адрес, рейтинг)
            AboutHotelView(
                name: name,
                address: address,
                rating: rating,
                ratingName: ratingName
            )
            
            // Цена за проживание
            Text("\(Constants.from) \(price) \(String.currency) ")
                .font(Font.Semibold.s30)
                .foregroundStyle(.black)
            +
            // Дополнительная информация о цене
            Text(priceForIt.lowercased())
                .foregroundStyle(Color.customDarkGray)
                .font(Font.Default.d16)
        }
    }
}
