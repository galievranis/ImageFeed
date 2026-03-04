//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by Ranis Galiev on 04.03.2026.
//

import UIKit

final class OAuth2Service {
    static let shared = OAuth2Service()
    private init() {}
    private let tokenStorage = OAuth2TokenStorage()
    
    private func makeOAuthTokenRequest(code: String) -> URLRequest? {
        guard var urlComponents = URLComponents(string: "https://unsplash.com/oauth/token") else {
            return nil
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: Constants.accessKey),
            URLQueryItem(name: "client_secret", value: Constants.secretKey),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "grant_type", value: "authorization_code"),
        ]
        
        guard let authTokenUrl = urlComponents.url else {
            return nil
        }
        
        var request = URLRequest(url: authTokenUrl)
        request.httpMethod = "POST"
        return request
    }
    
    func fetchOAuthToken(code: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let urlRequest = makeOAuthTokenRequest(code: code) else { return }

        let task = URLSession.shared.data(for: urlRequest) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let responseBody = try JSONDecoder().decode(OAuthTokenResponseBody.self, from: data)
                    self?.tokenStorage.token = responseBody.accessToken
                    completion(.success(responseBody.accessToken))
                } catch {
                    print("Decoding Error: \(error)")
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Network or Service Error: \(error)")
                completion(.failure(error))
            }
        }
    
        task.resume()
    }
}
