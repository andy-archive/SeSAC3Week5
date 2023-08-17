//
//  WeatherManager.swift
//  SeSAC3Week5
//
//  Created by Taekwon Lee on 2023/08/17.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherManager {
    
    static let shared = WeatherManager()
    
    func callRequestStringJSON(completionHandler: @escaping (JSON) -> Void) {
        
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(APIKey.latitude)&lon=\(APIKey.longitude)&appid=\(APIKey.weatherKey)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                completionHandler(json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func callRequestString(completionHandler: @escaping (String, String) -> Void) {
        
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(APIKey.latitude)&lon=\(APIKey.longitude)&appid=\(APIKey.weatherKey)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let temp = json["main"]["temp"].doubleValue - 273.15
                let humidity = json["main"]["humidity"].intValue
                
                completionHandler("TEMP: \(temp)", "HUMIDITY: \(humidity)")
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
