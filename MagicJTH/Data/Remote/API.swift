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

/// Cliente de la API
struct API {
    
    // MARK: - Propiedades
    
    /// Instancia única compartida por toda la aplicación.
    static let shared = API()
    
    /// URL base de la API de Magic
    private let baseURL = "https://api.magicthegathering.io/v1"
    
    // MARK: - Constructor
    
    /// Constructor privado para el Singleton.
    private init() {}
    
    // MARK: - Métodos
    
    /// Obtener la URL completa en función del endpoint que se quiere llamar.
    /// - Parameter endpoint: Endpoint que se quiere llamar.
    /// - Returns: URL completa formada por la URL base y el endpoint.
    private func getURL(endpoint: Endpoint) -> URL {
        URL(string: "\(baseURL)/\(endpoint.rawValue)")!
    }
    
    // MARK: - GET
    
    /// Hacer una petición GET a un recurso remoto de manera genérica a partir de un endpoint.
    /// - Parameter endpoint: Endpoint al que se quiere llamar.
    /// - Returns: Publisher que contiene los datos deseados ya decodeados o el error que se haya producido.
    func get<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, Error> {
        let url = getURL(endpoint: endpoint)
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .retry(1)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}
