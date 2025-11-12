//
//  APIClientModule.swift
//  APIClient
//
//  Created by Joao Barbosa on 29/05/2025.
//

import Locator

public enum APIClientModule {}

extension Locator.Kind {
  public static var apiClient: Locator.Kind<APIClient> { Locator.Kind("APIClient") }
}

public extension APIClientModule {
  public static func registerServices(in locator: Locator) {
    let client = MovieDatabaseAPIClient()
    locator.register(.apiClient, client)
  }
}

