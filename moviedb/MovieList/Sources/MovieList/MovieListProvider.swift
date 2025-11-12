//
//  MovieListProvider.swift
//  MovieList
//
//  Created by Joao Barbosa on 30/04/2025.
//

import Locator
import APIClient
import UIKit

public protocol MovieListProvider {

  @MainActor func movieListViewController() -> UIViewController?
}

public struct MovieListProviderImpl: MovieListProvider {

  private weak var locator: Locator?
  private let factory: MovieListFactory

  public init(locator: Locator) {
    self.locator = locator
    self.factory = MovieListFactoryImpl(
      movieDetailProvider: locator.resolve(.movieDetailProvider)
    )
  }

  @MainActor public func movieListViewController() -> UIViewController? {
    guard let locator = locator else {
      fatalError("Locator is not set")
    }
    return factory.makeMovieListViewController(
      apiClient: locator.resolve(.apiClient)
    )
  }
}
