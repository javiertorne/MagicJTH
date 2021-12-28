//
//  CustomError.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 28/12/21.
//

enum CustomError: Error {
    case badRequest
    case forbidden
    case notFound
    case internalServerError
    case serviceUnavailable
    case unknown
    case decoding
    case noInternet
}
