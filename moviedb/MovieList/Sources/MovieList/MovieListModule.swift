//
//  MovieListModule.swift
//  MovieList
//
//  Created by Joao Barbosa on 29/05/2025.
//

import Locator

public enum MovieListModule {}

extension Locator.Kind {
  public static var movieListProvider: Locator.Kind<MovieListProvider> { Locator.Kind("MovieListProvider") }
}
public extension MovieListModule {
  static func registerServices(in locator: Locator) {
    let movieListProvider = MovieListProviderImpl(locator: locator)
    locator.register(.movieListProvider, movieListProvider)
  }
}
