//
//  ReservationView.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 15.12.2023.
//

import SwiftUI

struct ReservationView: View {
    private enum Constants {
        static let pageLoading = "Загрузка страницы"
        static let pay = "Оплатить"
    }
    
    @ObservedObject var viewModel: ReservationViewModel
    @State private var email: String = .empty
    @State private var name: String = .empty
    @State private var lastName: String = .empty
    @State private var birthDate: String = .empty
    @State private var citizenship: String = .empty
    @State private var passportNumber: String = .empty
    @State private var validityPeriod: String = .empty
    @State private var addButtonHidden = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if viewModel.isLoading {
                ProgressView(Constants.pageLoading)
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
                        
                        BuyerInfoView(email: $email, validationRule: viewModel.isValidEmail)
                        
                        ForEach(viewModel.tourists, id: \.self) { item in
                            TouristInfoView(
                                name: name,
                                lastName: lastName,
                                birthDate: birthDate,
                                citizenship: citizenship,
                                passportNumber: passportNumber,
                                validityPeriod: validityPeriod,
                                validationRule: viewModel.isTextValid,
                                title: item
                            )
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
                        title: Constants.pay,
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
    private enum Constants {
        static let tour = "Тур"
        static let fuelCharge = "Топливный сбор"
        static let serviceCharge = "Сервисный сбор"
        static let toPay = "К оплате"
    }
    
    let tourPrice: Int
    let fuelCharge: Int
    let serviceCharge: Int
    let touristsCount: Int
    
    var body: some View {
        VStack(spacing: 16) {
            PriceItemView(title: Constants.tour, price: tourPrice * touristsCount)
            PriceItemView(title: Constants.fuelCharge, price: fuelCharge * touristsCount)
            PriceItemView(title: Constants.serviceCharge, price: serviceCharge * touristsCount)
            HStack {
                Text(Constants.toPay)
                    .font(Font.Default.d16)
                    .foregroundStyle(Color.customDarkGray)
                    .frame(maxWidth: 150, alignment: .leading)
                Text("\(totalPriceCounter()) \(String.currency)")
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
    private enum Constants {
        static let aboutBuyer = "Информация о покупателе"
        static let number = "Номер телефона"
        static let email = "Почта"
        static let description = "Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту"
    }
    
    @Binding var email: String
    let validationRule: (_ value: String) -> Bool
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            Text(Constants.aboutBuyer)
                .font(Font.Medium.m22)
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack(spacing: 8) {
                PhoneNumberTextField(title: Constants.number)
                
                BaseTextField(
                    text: $email,
                    validationRule: validationRule,
                    title: Constants.email,
                    keyboardType: .emailAddress,
                    capitalization: .never
                )
                
                Text(Constants.description)
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
    private enum Constants {
        static let addTourist = "Добавить туриста"
    }
    
    let onButtonTap: Closure.Void
    
    var body: some View {
        HStack {
            Text(Constants.addTourist)
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
    private enum Constants {
        static let departure = "Вылет из"
        static let arrivalCountry = "Страна, город"
        static let date = "Даты"
        static let numberOfNights = "Кол-во ночей"
        static let hotel = "Отель"
        static let room = "Номер"
        static let nutrition = "Питание"
    }
    
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
                title: Constants.departure,
                info: departure
            )
            ReservationInfoItemView(
                title: Constants.arrivalCountry,
                info: arrivalCountry
            )
            ReservationInfoItemView(
                title: Constants.date,
                info: startDate + " \(String.minus) " + endDate
            )
            ReservationInfoItemView(
                title: Constants.numberOfNights,
                info: "\(numberOfNights)"
            )
            ReservationInfoItemView(
                title: Constants.hotel,
                info: hotelName
            )
            ReservationInfoItemView(
                title: Constants.room,
                info: room
            )
            ReservationInfoItemView(
                title: Constants.nutrition,
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
            Text("\(price) \(String.currency)")
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
    private enum Constants {
        static let mask = "+X (XXX) XXX-XX-XX"
        static let seven = "+7"
    }
    
    @State var numberText = Constants.seven
    
    let title: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.customGray)
            NumbersBaseTextField(text: $numberText, title: title, mask: Constants.mask)
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
