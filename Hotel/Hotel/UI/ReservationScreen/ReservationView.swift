//
//  ReservationView.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 15.12.2023.
//

import SwiftUI

struct ReservationView: View {
    @ObservedObject var viewModel: ReservationViewModel
    @State var email: String = ""
    @State var addButtonHidden = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if viewModel.isLoading {
                ProgressView("Page is loading")
            } else if let _ = viewModel.error {
                FailView()
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 8) {
                        VStack(alignment: .leading) {
                            AboutHotelView(
                                name: viewModel.reservation.hotelName,
                                address: viewModel.reservation.hotelAdress,
                                rating: viewModel.reservation.horating,
                                ratingName: viewModel.reservation.ratingName
                            )
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(16)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundStyle(.white)
                        )
                        
                        ReservationInfoView(
                            departure: viewModel.reservation.departure,
                            arrivalCountry: viewModel.reservation.arrivalCountry,
                            startDate: viewModel.reservation.tourDateStart,
                            endDate: viewModel.reservation.tourDateStop,
                            numberOfNights: viewModel.reservation.numberOfNights,
                            hotelName: viewModel.reservation.hotelName,
                            room: viewModel.reservation.room,
                            nutrition: viewModel.reservation.nutrition
                        )
                        
                        BuyerInfoView(email: email, validationRule: viewModel.isValidEmail)
                        
                        ForEach(viewModel.tourists, id: \.self) { item in
                            TouristInfoView(validationRule: viewModel.isTextValid, title: item)
                                .padding(16)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .foregroundStyle(.white)
                                )
                        }
                        
                        AddTouristSectionView(onButtonTap: viewModel.addTourist)
                        
                        TotalPriceView(
                            tourPrice: viewModel.reservation.tourPrice,
                            fuelCharge: viewModel.reservation.fuelCharge,
                            serviceCharge: viewModel.reservation.serviceCharge,
                            touristsCount: viewModel.tourists.count
                        )
                    }
                }
                .background(Color.customGray)
                .padding(.bottom, 60)
                ZStack {
                    PrimaryButton(
                        title: "Оплатить",
                        action: { viewModel.openSuccessScreen() }
                    )
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                }
                .background(Color.white)
            }
        }
        .onAppear {
            viewModel.fetchReservation()
        }
    }
}

private struct TotalPriceView: View {
    let tourPrice: Int
    let fuelCharge: Int
    let serviceCharge: Int
    let touristsCount: Int
    
    var body: some View {
        VStack(spacing: 16) {
            PriceItemView(title: "Тур", price: tourPrice * touristsCount)
            PriceItemView(title: "Топливный сбор", price: fuelCharge * touristsCount)
            PriceItemView(title: "Сервисный сбор", price: serviceCharge * touristsCount)
            HStack {
                Text("К оплате")
                    .font(Font.Default.d16)
                    .foregroundStyle(Color.customDarkGray)
                    .frame(maxWidth: 150, alignment: .leading)
                Text("\(totalPriceCounter()) ₽")
                    .font(Font.Semibold.s16)
                    .foregroundStyle(.customBlue)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.white)
        )
    }
    
    private func totalPriceCounter() -> Int {
        (tourPrice + fuelCharge + serviceCharge) * touristsCount
    }
}

private struct BuyerInfoView: View {
    let email: String
    let validationRule: (_ value: String) -> Bool
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            Text("Информация о покупателе")
                .font(Font.Medium.m22)
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack(spacing: 8) {
                PhoneNumberTextField(title: "Номер телефона")
                
                BaseTextField(
                    text: email,
                    title: "Почта",
                    keyboardType: .emailAddress,
                    capitalization: .never,
                    validationRule: validationRule
                )
                
                Text("Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту")
                    .font(Font.Medium.m14)
                    .foregroundStyle(.customDarkGray)
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.white)
        )
    }
}

private struct AddTouristSectionView: View {
    let onButtonTap: Closure.Void
    
    var body: some View {
        HStack {
            Text("Добавить туриста")
                .font(Font.Medium.m22)
                .foregroundStyle(.black)
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .frame(width: 32, height: 32)
                    .foregroundStyle(.customBlue)
                Image(systemSymbol: .plus)
                    .foregroundStyle(.white)
                    .onTapGesture {
                        onButtonTap()
                    }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.white)
        )
    }
}

private struct ReservationInfoView: View {
    let departure: String
    let arrivalCountry: String
    let startDate: String
    let endDate: String
    let numberOfNights: Int
    let hotelName: String
    let room: String
    let nutrition: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ReservationInfoItemView(
                title: "Вылет из",
                info: departure
            )
            ReservationInfoItemView(
                title: "Страна, город",
                info: arrivalCountry
            )
            ReservationInfoItemView(
                title: "Даты",
                info: startDate + " - " + endDate
            )
            ReservationInfoItemView(
                title: "Кол-во ночей",
                info: "\(numberOfNights)"
            )
            ReservationInfoItemView(
                title: "Отель",
                info: hotelName
            )
            ReservationInfoItemView(
                title: "Номер",
                info: room
            )
            ReservationInfoItemView(
                title: "Питание",
                info: nutrition
            )
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.white)
        )
    }
}

private struct PriceItemView: View {
    let title: String
    let price: Int
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundStyle(Color.customDarkGray)
                .frame(maxWidth: 150, alignment: .leading)
            Text("\(price) ₽")
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

private struct ReservationInfoItemView: View {
    let title: String
    let info: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundStyle(Color.customDarkGray)
                .frame(maxWidth: 150, alignment: .leading)
            Text(info)
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .font(Font.Default.d16)
    }
}

private struct PhoneNumberTextField: View {
    let title: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.customGray)
            NumbersBaseTextField(title: title, mask: "+X (XXX) XXX-XX-XX", text: "+7")
        }
        .frame(height: 52)
    }
}

#Preview {
    ReservationView(
        viewModel: ReservationViewModel(
            coordinator: ReservationCoordinator(),
            networkManager: NetworkManager()
        )
    )
}
