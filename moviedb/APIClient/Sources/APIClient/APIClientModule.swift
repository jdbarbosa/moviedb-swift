//
//  APIClientModule.swift
//  APIClient
//
//  Created by Joao Barbosa on 29/05/2025.
//

import Locator

public enum APIClientModule {
    /// Kinds this module resolves from the locator. None: it is a leaf.
    public static let requiredKinds: [AnyLocatorKind] = []
}

extension Locator.Kind {
    public static var apiClient: Locator.Kind<APIClient> { Locator.Kind("APIClient") }
}

extension AnyLocatorKind {
  public static let apiClient = Locator.Kind<any APIClient>.apiClient.erased
}

public extension APIClientModule {
    @MainActor
    static func registerServices(in locator: Locator) {
        locator.register(.apiClient) { _ in
            MovieDatabaseAPIClient()
        }
    }
}

