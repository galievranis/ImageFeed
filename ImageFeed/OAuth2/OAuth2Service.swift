//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by Ranis Galiev on 04.03.2026.
//

import Foundation
import Logging

final class OAuth2Service {
    // MARK: - Singleton
    static let shared = OAuth2Service()
    private init() {}
    
    // MARK: - Properties
    private let tokenStorage = OAuth2TokenStorage.shared
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    // MARK: - Functions
    func fetchOAuthToken(code: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        guard let urlRequest = makeOAuthTokenRequest(code: code) else { return }

        let task = URLSession.shared.data(for: urlRequest) { [self] result in
            switch result {
            case .success(let data):
                do {
                    let responseBody = try decoder.decode(OAuthTokenResponseBody.self, from: data)
                    tokenStorage.token = responseBody.accessToken
                    completion(.success(responseBody.accessToken))
                } catch {
                    logger.error("Decoding error", metadata: ["error:": "\(error)"])
                    completion(.failure(error))
                }
            case .failure(let error):
                logger.error("Network or service error:", metadata: ["error:": "\(error)"])
                completion(.failure(error))
            }
        }
    
        task.resume()
    }
    
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
        request.httpMethod = HTTPMethods.post.rawValue
        return request
    }
}
