//
//  OAuthTokenResponseBody.swift
//  ImageFeed
//
//  Created by Ranis Galiev on 04.03.2026.
//

struct OAuthTokenResponseBody: Decodable {
    let accessToken: String
    let tokenType: String
    let scope: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case scope = "scope"
    }
}
