//
//  API.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 27/12/21.
//

import Foundation
import Combine

/// Endpoints de la API.
enum Endpoint: String {
    case cardsList = "cards"
}

/// Cliente de la API. Se ha creado con Combine y con funciones genéricas para poder obtener cualquier tipo de dato con una sola función.
struct API {
    
    // MARK: - Propiedades
    
    static let shared = API()
    private let baseURL = "https://api.magicthegathering.io/v1"
    
    // MARK: - Constructor
    
    private init() {}
    
    // MARK: - Métodos
    
    private func getURL(endpoint: Endpoint) -> URL {
        URL(string: "\(baseURL)/\(endpoint.rawValue)")!
    }
    
    // MARK: - GET
    
    func get<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, Error> {
        let url = getURL(endpoint: endpoint)
        
        if !NetworkMonitor.shared.isConnected {
            return Result<T, Error>.Publisher(.failure(CustomError.noInternet)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { result in
                let decoder = JSONDecoder()
                guard let urlResponse = result.response as? HTTPURLResponse else { throw CustomError.unknown }
                let statusCode = urlResponse.statusCode
                switch statusCode {
                case 200...299:
                    return try decoder.decode(T.self, from: result.data)
                case 400:
                    throw CustomError.badRequest
                case 403:
                    throw CustomError.forbidden
                case 404:
                    throw CustomError.notFound
                case 500:
                    throw CustomError.internalServerError
                case 503:
                    throw CustomError.serviceUnavailable
                default:
                    throw CustomError.unknown
                }
            }
            .tryCatch { error -> AnyPublisher<T, Error> in
                throw CustomError.decoding
            }
            .eraseToAnyPublisher()
        
        // Alternativa sin control de errores:
        /*return URLSession.shared.dataTaskPublisher(for: url)
            .retry(1)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()*/
    }
    
}
