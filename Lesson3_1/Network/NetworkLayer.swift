//
//  NetworkLayer.swift
//  Lesson3_1
//
//  Created by Evgeny Mastepan on 27.12.2024.
//

import Foundation

class NetworkLayer{
//    let url = "https://api.open-meteo.com/v1"
    
    func sendRequest(){
        var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "api.open-meteo.com"
            urlComponents.path = "/v1/forecast"
            urlComponents.queryItems = [
                URLQueryItem(name: "latitude", value: "43.8029"),
                URLQueryItem(name: "longitude", value: "131.946"),
                URLQueryItem(name: "hourly", value: "temperature_2m"),
                ]
        
        guard let reqUrl = urlComponents.url else { return }
        var urlRequest = URLRequest(url: reqUrl)
        urlRequest.httpMethod = "GET"
// MARK: - Опции.
//        urlRequest.allHTTPHeaderFields = [""] //При авторизации через header
//        urlRequest.httpBody //для JSON
        URLSession.shared.dataTask(with: urlRequest) { data, responce, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "error connection")
                return
            }
            guard let data = data else {
                print("Recieving data error.")
                return
            }
//MARK: - отладочная информация.
//            print (String(decoding: data, as: UTF8.self))
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                print("Координаты места: \(weather.latitude) широты и \(weather.longitude) долготы")
                
                let weight = weather.hourly.time.count - 1
                for num in 0...weight {
                    print("На дату/время: \(weather.hourly.time[num]) будет температура: \(weather.hourly.temperature2m[num])")
                }
                
            } catch {
                print("Error decoding JSON: \(error)")
            }
            
            
        }.resume()
    }
}


//MARK: -Тут шпаргалка по JSON формату API данного ресурса.

//$ curl "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current=temperature_2m,wind_speed_10m&hourly=temperature_2m,relative_humidity_2m,wind_speed_10m"
//  https://api.open-meteo.com/v1/forecast?latitude=43.80&longitude=131.946&hourly=temperature_2m
//{
//  "current": {
//    "time": "2022-01-01T15:00"
//    "temperature_2m": 2.4,
//    "wind_speed_10m": 11.9,
//  },
//  "hourly": {
//    "time": ["2022-07-01T00:00","2022-07-01T01:00", ...]
//    "wind_speed_10m": [3.16,3.02,3.3,3.14,3.2,2.95, ...],
//    "temperature_2m": [13.7,13.3,12.8,12.3,11.8, ...],
//    "relative_humidity_2m": [82,83,86,85,88,88,84,76, ...],
//  }
//}
