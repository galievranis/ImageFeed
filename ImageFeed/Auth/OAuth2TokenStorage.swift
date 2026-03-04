//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Ranis Galiev on 04.03.2026.
//

import Foundation

final class OAuth2TokenStorage {
    private let tokenKey = "bearerToken"
    
    var token: String? {
        get {
            UserDefaults.standard.string(forKey: tokenKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: tokenKey)
        }
    }
}
