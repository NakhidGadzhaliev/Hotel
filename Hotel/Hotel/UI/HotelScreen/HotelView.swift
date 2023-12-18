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
                ProgressView("Page is loading")
            } else if let _ = viewModel.error {
                FailView()
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 8) {
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
                        
                        DetailInfoView(
                            peculiarities: viewModel.hotel.aboutTheHotel.peculiarities,
                            description: viewModel.hotel.aboutTheHotel.description
                        )
                    }
                }
                .background(Color.customGray)
                .padding(.bottom, 60)
                ZStack {
                    PrimaryButton(
                        title: "К выбору номера",
                        action: { viewModel.openRoomScreen(with: viewModel.hotel.name) }
                    )
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                }
                .background(Color.white)
            }
        }
        .onAppear {
            viewModel.fetchHotel()
        }
    }
}

private struct DetailInfoView: View {
    let peculiarities: [String]
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Об отеле")
                .font(Font.Medium.m22)
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            AdvantagesView(peculiarities: peculiarities)
            
            Text(description)
                .font(Font.Default.d16)
                .foregroundStyle(.black.opacity(0.9))
            
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

private struct AdditionalInfoView: View {
    var body: some View {
        VStack(spacing: 0) {
            AdditionalInfoItemView(icon: Image(asset: .emojiHappy), title: "Удобства", description: "Самое необходимое")
            Divider()
                .background(Color.customDarkGray)
                .padding(.trailing, 31)
                .padding(.leading, 69)
            AdditionalInfoItemView(icon: Image(asset: .tickSquare), title: "Что включено", description: "Самое необходимое")
            Divider()
                .background(Color.customDarkGray)
                .padding(.trailing, 31)
                .padding(.leading, 69)
            AdditionalInfoItemView(icon: Image(asset: .closeSquare), title: "Что не включено", description: "Самое необходимое")
        }
    }
}

private struct AdditionalInfoItemView: View {
    let icon: Image
    let title: String
    let description: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(.customLightGray)
            HStack(alignment: .center, spacing: 12) {
                icon
                    .resizable()
                    .frame(width: 24, height: 24)
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(Font.Medium.m16)
                        .foregroundStyle(.black)
                    Text(description)
                        .font(Font.Medium.m14)
                        .foregroundStyle(.customDarkGray)
                }
                Spacer()
                Image(systemSymbol: .chevronRight)
            }
            .padding(.horizontal, 31)
            .padding(.vertical, 15)
        }
    }
}

private struct MainInfoView: View {
    let rating: Int
    let ratingName: String
    let name: String
    let address: String
    let price: Int
    let priceForIt: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            AboutHotelView(
                name: name,
                address: address,
                rating: rating,
                ratingName: ratingName
            )
            
            Text("от \(price) ₽ ")
                .font(Font.Semibold.s30)
                .foregroundStyle(.black)
            +
            Text(priceForIt.lowercased())
                .foregroundStyle(Color.customDarkGray)
                .font(Font.Default.d16)
        }
    }
}

#Preview {
    HotelView(
        viewModel: HotelViewModel(
            coordinator: HotelCoordinator(),
            networkManager: NetworkManager()
        )
    )
}
