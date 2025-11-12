//
//  MovieListView_Previews.swift
//  MovieList
//
//  Created by Joao Barbosa on 30/04/2025.
//

import SwiftUI
import Combine
import APIClient
import Models

final class MovieListRouterPreview: MovieListRouter {
  func routeToMovieDetails(movie: Movie) {}
}

final class MovieListRepositoryPreview: MovieListRepository {
  func popularMovies(page: Int) -> AnyPublisher<MovieListResponse, APIError> {
    Just(MovieListResponse(results: []))
      .setFailureType(to: APIError.self)
      .eraseToAnyPublisher()
  }
  
  func searchMovies(query: String, page: Int) -> AnyPublisher<MovieListResponse, APIError> {
    Just(MovieListResponse(results: []))
      .setFailureType(to: APIError.self)
      .eraseToAnyPublisher()
  }
  
  func fetchMovies() async throws -> [Movie] {
    return []
  }
}

struct MovieListView_Previews: PreviewProvider {

  static var previews: some View {
    MovieListView(viewModel: MovieListViewModel(
      router: MovieListRouterPreview(),
      repository: MovieListRepositoryPreview()))
  }
}
