//
//  ReservationView.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 15.12.2023.
//

import SwiftUI

// Экран оформления бронирования
struct ReservationView: View {
    @ObservedObject var viewModel: ReservationViewModel
    @State private var email: String = .empty
    @State private var number: String = .empty
    @State private var showAlert = false
    
    // Вычисляемое свойство для проверки валидности всех полей
    private var areAllFieldsValid: Bool {
        return viewModel.tourists.allSatisfy { $0.areFieldsValid() } &&
        viewModel.isEmailValid(email) && viewModel.isPhoneNumberValid(number)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Отображение индикатора загрузки при загрузке данных
            if viewModel.isLoading {
                ProgressView(Constants.pageLoading)
            } else if let _ = viewModel.error {
                // Отображение экрана ошибки при неудачной загрузке
                FailView()
            } else {
                // Отображение основного контента
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
                    .padding(.top, 8)
                    .padding(.bottom, 12)
                    .background(Color.customGray)
                }
                .padding(.bottom, 60)
                
                // Отображение алерта при не валидных полях
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text(Constants.alertTitle),
                        message: Text(Constants.alertMessage),
                        dismissButton: .default(Text(Constants.ok))
                    )
                }
                
                // Кнопка для подтверждения бронирования
                payButton
            }
        }
        .onAppear {
            // Запрос данных о бронировании при появлении экрана
            viewModel.fetchReservation()
        }
    }
    
    // Секция с информацией об отеле
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
    
    // Секция с информацией о бронировании
    var reservationInfoSection: some View {
        TourInfoView(
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
    
    // Секция с информацией о покупателе
    var buyerInfoSection: some View {
        BuyerInfoView(
            email: $email,
            number: $number,
            isValidated: viewModel.isEmailValid(email),
            isNumberValidated: viewModel.isPhoneNumberValid(number)
        )
    }
    
    // Секция с информацией о туристах
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
    
    // Кнопка для подтверждения бронирования
    var payButton: some View {
        ZStack {
            PrimaryButton(
                title: Constants.payButtonTitle,
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

// Секция с общей стоимостью бронирования
private struct TotalPriceView: View {
    let tourPrice: Int
    let fuelCharge: Int
    let serviceCharge: Int
    let touristsCount: Int
    
    var body: some View {
        VStack(spacing: 16) {
            // Отображение стоимости тура, топливного сбора и сервисного сбора
            PriceItemView(title: Constants.tour, price: tourPrice * touristsCount)
            PriceItemView(title: Constants.fuelCharge, price: fuelCharge * touristsCount)
            PriceItemView(title: Constants.serviceCharge, price: serviceCharge * touristsCount)
            
            // Отображение общей стоимости
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
    
    // Вычисляемое свойство для подсчета общей стоимости
    private func totalPriceCounter() -> Int {
        (tourPrice + fuelCharge + serviceCharge) * touristsCount
    }
}

// Секция с информацией о покупателе
private struct BuyerInfoView: View {
    @Binding var email: String
    @Binding var number: String
    let isValidated: Bool
    let isNumberValidated: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Заголовок секции
            Text(Constants.infoAboutBuyer)
                .font(Font.Medium.m22)
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // Ввод данных о номере и email покупателя
            VStack(spacing: 8) {
                BaseNumberField(
                    number: $number,
                    title: Constants.numberFieldTitle,
                    mask: Constants.maskForNumber,
                    isNumberValidated: isNumberValidated,
                    maxLength: Constants.phoneNumberMaskCount
                )
                
                BaseTextField(
                    text: $email,
                    isValidated: isValidated,
                    title: Constants.emailFieldTitle,
                    keyboardType: .emailAddress,
                    capitalization: .never
                )
                
                // Дополнительная информация для покупателя
                Text(Constants.descriptionToBuyer)
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

// Секция для добавления туриста
private struct AddTouristSectionView: View {
    let onButtonTap: Closure.Void
    
    var body: some View {
        HStack {
            Text(Constants.addTourist)
                .font(Font.Medium.m22)
                .foregroundStyle(.black)
            
            Spacer()
            
            // Кнопка для добавления туриста
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

// Секция с информацией о туре
private struct TourInfoView: View {
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
            // Отображение информации о туре
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

// Секция для отображения элемента стоимости
private struct PriceItemView: View {
    let title: String
    let price: Int
    
    var body: some View {
        HStack {
            // Заголовок и стоимость
            Text(title)
                .foregroundStyle(Color.customDarkGray)
                .frame(maxWidth: 150, alignment: .leading)
            
            Text("\(price) \(String.currency)")
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

// Секция для отображения элемента информации о бронировании
private struct ReservationInfoItemView: View {
    let title: String
    let info: String
    
    var body: some View {
        HStack {
            // Заголовок и информация
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
