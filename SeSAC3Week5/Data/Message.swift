//
//  Message.swift
//  SeSAC3Week5
//
//  Created by Taekwon Lee on 2023/08/16.
//

import Foundation

// MARK: - Message
struct Message: Codable {
    let service, version: String
    let result: Result
    let type: String

    enum CodingKeys: String, CodingKey {
        case service = "@service"
        case version = "@version"
        case result
        case type = "@type"
    }
}
