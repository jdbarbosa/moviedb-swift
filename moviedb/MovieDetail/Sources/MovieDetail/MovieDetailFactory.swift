//
//  MovieDetailFactory.swift
//  MovieDetail
//
//  Created by Joao Barbosa on 29/05/2025.
//

import UIKit
import APIClient
import Models

public protocol MovieDetailFactory {
  @MainActor
  func makeMovieDetailViewController(movie: Movie) -> UIViewController?
}

package final class MovieDetailFactoryImpl: MovieDetailFactory {

  init() {}

  @MainActor
  public func makeMovieDetailViewController(
    movie: Movie
  ) -> UIViewController? {
    let movieDetailViewController = MovieDetailViewController()
    let viewModel = MovieDetailViewModel(
      movie: movie
    )
    movieDetailViewController.bind(viewModel: viewModel)
    return movieDetailViewController
  }
}
