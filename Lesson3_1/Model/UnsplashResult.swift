//
//  UnsplashResult.swift
//  Lesson3_1
//
//  Created by Evgeny Mastepan on 27.12.2024.
//

import Foundation

struct UnsplashResult: Decodable{
    
}


import Foundation

struct Weather: Decodable {
    let latitude: Double
    let longitude: Double
    let generationTimeMS: Double
    let utcOffsetSeconds: Int
    let timezone: String
    let timezoneAbbreviation: String
    let elevation: Double
    let hourlyUnits: HourlyUnits
    let hourly: Hourly
    
    private enum CodingKeys: String, CodingKey {
        case latitude, longitude, generationTimeMS = "generationtime_ms", utcOffsetSeconds = "utc_offset_seconds", timezone, timezoneAbbreviation = "timezone_abbreviation", elevation, hourlyUnits = "hourly_units", hourly
    }
}

struct HourlyUnits: Decodable {
    let time: String
    let temperature2m: String
    
    private enum CodingKeys: String, CodingKey {
        case time, temperature2m = "temperature_2m"
    }
}

struct Hourly: Decodable {
    let time: [String]
    let temperature2m: [Double]
    
    private enum CodingKeys: String, CodingKey {
        case time, temperature2m = "temperature_2m"
    }
}
