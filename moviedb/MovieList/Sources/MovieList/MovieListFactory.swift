//
//  MovieListFactory.swift
//  moviedb
//
//  Created by Joao Barbosa on 23/04/2025.
//

import UIKit
import APIClient
import MovieDetail

public protocol MovieListFactory {
  @MainActor
  func makeMovieListViewController(
    apiClient: APIClient
  ) -> UIViewController?
}

package final class MovieListFactoryImpl: MovieListFactory {

  private let movieDetailProvider: MovieDetailProvider

  init(movieDetailProvider: MovieDetailProvider) {
    self.movieDetailProvider = movieDetailProvider
  }

  @MainActor
  public func makeMovieListViewController(
    apiClient: APIClient
  ) -> UIViewController? {
    let movieListViewController = MovieListViewController()
    let repository = MovieListRepositoryImpl(apiClient: apiClient)
    let router = MovieListRouterImpl(
      viewController: movieListViewController,
      movieDetailProvider: movieDetailProvider
    )
    let viewModel = MovieListViewModel(
      router: router,
      repository: repository
    )
    movieListViewController.bind(viewModel: viewModel)
    return movieListViewController

  }
}
