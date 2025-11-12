//
//  MovieDetailProvider.swift
//  MovieDetail
//
//  Created by Joao Barbosa on 29/05/2025.
//

import Locator
import APIClient
import UIKit
import Models

public protocol MovieDetailProvider {
  @MainActor func movieDetailViewController(movie: Movie) -> UIViewController?
}

public struct MovieDetailProviderImpl: MovieDetailProvider {

  private let locator: Locator

  public init(locator: Locator) {
    self.locator = locator
  }


  @MainActor public func movieDetailViewController(movie: Movie) -> UIViewController? {
    //let apiClient = locator.resolve(.apiClient)
    let factory = MovieDetailFactoryImpl()
    return factory.makeMovieDetailViewController(movie: movie)
  }
}
