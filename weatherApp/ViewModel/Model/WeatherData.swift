//
//  WeatherData.swift
//  weatherApp
//
//  Created by Sarika on 04.04.19.
//  Copyright © 2019 Sarika. All rights reserved.
//

import UIKit

//MARK: JSON Seralization structures

struct WeatherData : Codable {
    let cod: String?
    let message: Float?
    let cnt: Int?
    let list: [list]
}

struct list : Codable {
    let dt: Int?
    let main : main
    let weather: [weatherCondition]
    let clouds: clouds
    let wind: wind
    let snow:snow?
    let sys : sys
    let date: String?
    
    enum CodingKeys : String, CodingKey {
        case dt
        case main
        case weather
        case clouds
        case wind
        case snow
        case sys
        case date = "dt_txt"
    }
}

struct main: Codable {
    let temprature: Float?
    let mintemprature: Float?
    let maxtemprature: Float?
    let pressure: Float?
    let sealevel: Float?
    let grndlevel: Float?
    let humidity: Int?
    let kftemprature: Float?
    
    enum CodingKeys : String, CodingKey {
        case temprature = "temp"
        case mintemprature = "temp_min"
        case maxtemprature = "temp_max"
        case sealevel = "sea_level"
        case grndlevel = "grnd_level"
        case kftemprature = "temp_kf"
        case humidity
        case pressure
    }
}

struct weatherCondition: Codable {
    let id: Int?
    let main:String?
    let description: String?
    let icon: String?
}

struct sys: Codable {
    let pod : String?
}

struct snow: Codable {
    let threeHour: Float?
    
    enum CodingKeys : String, CodingKey {
        case threeHour = "3h"
    }
}

struct clouds: Codable {
    let all: Int?
}

struct wind: Codable {
    let speed: Float?
    let deg: Float?
}
