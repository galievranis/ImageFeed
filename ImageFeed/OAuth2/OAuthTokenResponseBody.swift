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
}

