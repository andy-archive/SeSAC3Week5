//
//  Endpoint.swift
//  SeSAC3Week5
//
//  Created by jack on 2023/08/14.
//

import Foundation

// CaseIterable - 모든 케이스를 배열로 만들 수 있다
enum Nasa: String, CaseIterable {
    
    // 열거형은 인스턴스를 생성할 수 없다
    static let baseURL = "https://apod.nasa.gov/apod/image/" // static 제거 시 오류 - Enums must not contain stored properties
    
    case one = "2308/sombrero_spitzer_3000.jpg"
    case two = "2212/NGC1365-CDK24-CDK17.jpg"
    case three = "2307/M64Hubble.jpg"
    case four = "2306/BeyondEarth_Unknown_3000.jpg"
    case five = "2307/NGC6559_Block_1311.jpg"
    case six = "2304/OlympusMons_MarsExpress_6000.jpg"
    case seven = "2305/pia23122c-16.jpg"
    case eight = "2308/SunMonster_Wenz_960.jpg"
    case nine = "2307/AldrinVisor_Apollo11_4096.jpg"
    
    // test - 인스턴스 연산 프로퍼티 -> 값을 저장하고 있지는 않고, 값을 사용가능한 통로로서의 역할만을 담당한다
    var test: URL {
        return URL(string: "https://www.naver.com")!
    }
    
    static var photo: URL {
        return URL(string: Nasa.baseURL + Nasa.allCases.randomElement()!.rawValue)!
        // baseURL static 제거 시 오류
        /// Instance member 'baseURL' cannot be used on type 'Nasa'
        
        // photo static 제거 시 오류
        // 사용하는 변수 안에 타입 프로퍼티가 있기에 인스턴스를 담을 수 없다
        /// Static member 'allCases' cannot be used on instance of type 'Nasa'
        /// Static member 'baseURL' cannot be used on instance of type 'Nasa'
    }
}
