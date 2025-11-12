//
//  APIError.swift
//  APIClient
//
//  Created by Joao Barbosa on 24/04/2025.
//

import Foundation

public enum APIError: Error {
    /// For client side errors, such as failing to build a request to the server.
    case client

    /// For decoding errors, such as failing to decode a response from the server.
    case decoding

    /// For network errors, such as 404 not found etc.
    case network

    /// For when the network is unreachable.
    case unreachable

    /// For when login credentials are no longer valid, or unexisting
    case notAuthenticated

    /// ...

}

extension APIError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .client:
            return "Client error."
        case .decoding:
            return "Decoding error."
        case .network:
            return "Network error."
        case .unreachable:
            return "Unreachable."
        case .notAuthenticated:
            return "Not Authenticated."
        }
    }
}
