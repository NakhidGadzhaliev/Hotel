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
        static let seven = "+7"
        static let alertTitle = "Внимание"
        static let alertMessage = "Заполните корректно все данные"
        static let ok = "OK"
    }
    
    @ObservedObject var viewModel: ReservationViewModel
    @State private var email: String = .empty
    @State private var number: String = Constants.seven
    @State private var showAlert = false
    
    private var areAllFieldsValid: Bool {
        return viewModel.tourists.allSatisfy { $0.areFieldsValid() } &&
        viewModel.isEmailValid(email) && viewModel.isPhoneNumberValid(number)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if viewModel.isLoading {
                ProgressView(Constants.pageLoading)
            } else if let _ = viewModel.error {
                FailView()
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 8) {
                        aboutHotelSection
                        reservationInfoSection
                        buyerInfoSection
                        touristsInfoSection
                        
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
                
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text(Constants.alertTitle),
                        message: Text(Constants.alertMessage),
                        dismissButton: .default(Text(Constants.ok))
                    )
                }
                
                payButton
                
            }
        }
        .onAppear {
            viewModel.fetchReservation()
        }
    }
    
    var aboutHotelSection: some View {
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
    }
    
    var reservationInfoSection: some View {
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
    }
    
    var buyerInfoSection: some View {
        BuyerInfoView(
            email: $email,
            number: $number,
            isValidated: viewModel.isEmailValid(email),
            isNumberValidated: viewModel.isPhoneNumberValid(number)
        )
    }
    
    var touristsInfoSection: some View {
        ForEach(viewModel.tourists.indices, id: \.self) { index in
            TouristInfoView(
                tourist: $viewModel.tourists[index],
                title: viewModel.tourists[index].number
            )
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(.white)
            )
        }
    }
    
    var payButton: some View {
        ZStack {
            PrimaryButton(
                title: Constants.pay,
                action: {
                    if areAllFieldsValid {
                        viewModel.openSuccessScreen()
                    } else {
                        showAlert = true
                    }
                }
            )
            .padding(.horizontal, 16)
            .padding(.top, 12)
        }
        .background(Color.white)
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
    @Binding var number: String
    let isValidated: Bool
    let isNumberValidated: Bool
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            Text(Constants.aboutBuyer)
                .font(Font.Medium.m22)
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack(spacing: 8) {
                PhoneNumberTextField(numberText: $number, title: Constants.number, isValidated: isNumberValidated)
                BaseTextField(text: $email, isValidated: isValidated, title: Constants.email, keyboardType: .emailAddress, capitalization: .never)
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
    }
    
    @Binding var numberText: String
    
    let title: String
    let isValidated: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.customGray)
            BaseNumberField(text: $numberText, title: title, mask: Constants.mask, isValidated: isValidated)
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
