//
//  MovieListRouter.swift
//  moviedb
//
//  Created by Joao Barbosa on 23/04/2025.
//

import UIKit
import MovieDetail
import Models

protocol MovieListRouter {
  @MainActor func routeToMovieDetails(movie: Movie)
}

final class MovieListRouterImpl: MovieListRouter {

  private let viewController: UIViewController
  private let movieDetailProvider: MovieDetailProvider

  init(
    viewController: UIViewController,
    movieDetailProvider: MovieDetailProvider
  ) {
    self.viewController = viewController
    self.movieDetailProvider = movieDetailProvider
  }

  @MainActor func routeToMovieDetails(movie: Movie) {
    guard let movieDetailViewController = movieDetailProvider.movieDetailViewController(movie: movie) else { return }
    guard let navigationController = viewController.navigationController else { return }
    navigationController.pushViewController(movieDetailViewController, animated: true)
  }
}
