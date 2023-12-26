//
//  Constants.swift
//  Hotel
//
//  Created by Нахид Гаджалиев on 26.12.2023.
//

import Foundation

enum Constants {
    static let hotelUrl = "https://run.mocky.io/v3/d144777c-a67f-4e35-867a-cacc3b827473"
    static let roomUrl = "https://run.mocky.io/v3/8b532701-709e-4194-a41c-1a903af00195"
    static let reservationUrl = "https://run.mocky.io/v3/63866c74-d593-432c-af8e-f279d1a8d2ff"
    static let noConnection = "Нет подключения к сети"
    static let tryReload = "Пожалуйста, попробуйте перезагрузить приложение"
    static let name = "Имя"
    static let lastName = "Фамилия"
    static let birthDate = "Дата рождения"
    static let dateMask = "XX.XX.XXXX"
    static let citizenship = "Гражданство"
    static let passportNumber = "Номер загранпаспорта"
    static let passportExporationDate = "Срок действия загранпаспорта"
    static let unknownError = "Unknown error"
    static let hotelTitle = "Отель"
    static let hotelControllerFailed = "Failed HotelController"
    static let pageLoading = "Загрузка страницы"
    static let chooseNumber = "К выбору номера"
    static let aboutHotel = "Об отеле"
    static let facilities = "Удобства"
    static let essentials = "Самое необходимое"
    static let included = "Что включено"
    static let notIncluded = "Что не включено"
    static let from = "от"
    static let roomControllerFailed = "Failed RoomController"
    static let detailsAboutRoom = "Подробнее о номере"
    static let chooseRoom = "Выбрать номер"
    static let reservationTitle = "Бронирование"
    static let reservationControllerFailed = "Failed ReservationController"
    static let payButtonTitle = "Оплатить"
    static let alertTitle = "Внимание"
    static let alertMessage = "Заполните корректно все данные"
    static let ok = "OK"
    static let tour = "Тур"
    static let fuelCharge = "Топливный сбор"
    static let serviceCharge = "Сервисный сбор"
    static let toPay = "К оплате"
    static let infoAboutBuyer = "Информация о покупателе"
    static let numberFieldTitle = "Номер телефона"
    static let emailFieldTitle = "Почта"
    static let descriptionToBuyer = "Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту"
    static let maskForNumber = "+X (XXX) XXX-XX-XX"
    static let addTourist = "Добавить туриста"
    static let departure = "Вылет из"
    static let arrivalCountry = "Страна, город"
    static let date = "Даты"
    static let numberOfNights = "Кол-во ночей"
    static let hotel = "Отель"
    static let room = "Номер"
    static let nutrition = "Питание"
    static let firstTourist = "Первый турист"
    static let tourist = "турист"
    static let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    static let format = "SELF MATCHES %@"
    static let first = "Первый"
    static let second = "Второй"
    static let third = "Третий"
    static let fourth = "Четвертый"
    static let fifth = "Пятый"
    static let successTitle = "Заказ оплачен"
    static let successControllerFailed = "Failed SuccessController"
    static let orderIsAccepted = "Ваш заказ принят в работу"
    static let confirmation = "Подтверждение заказа №104893 может занять некоторое время (от 1 часа до суток). \n Как только мы получим ответ от туроператора, вам на почту придет уведомление."
    static let superButtonTitle = "Супер!"
    
    static let phoneNumberMaskCount = 18
    static let dateMaskCount = 10
    static let passportNumberMaxLength = 12
}
