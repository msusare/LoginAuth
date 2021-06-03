//
//  UserDetails.swift
//  LoginAuth
//
//  Created by Mayur Susare on 03/06/21.
//

import Foundation

// MARK: - UserDetails
struct UserDetails: Codable {
    let userID, password: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case password
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}


