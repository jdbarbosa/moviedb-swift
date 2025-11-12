//
//  MovieListRequest.swift
//  MovieList
//
//  Created by Joao Barbosa on 30/04/2025.
//

import APIClient
import Combine
import Models

protocol MovieListRepository {
  func popularMovies(page: Int) -> AnyPublisher<MovieListResponse, APIError>
  func searchMovies(query: String, page: Int) -> AnyPublisher<MovieListResponse, APIError>
}

final class MovieListRepositoryImpl: MovieListRepository {

  private let apiClient: APIClient

  init(apiClient: APIClient) {
    self.apiClient = apiClient
  }

  func popularMovies(page: Int) -> AnyPublisher<MovieListResponse, APIError> {
    apiClient.sendURLSessionRequest(for: PopularMoviesRequest(page: page))
  }

  func searchMovies(query: String, page: Int) -> AnyPublisher<MovieListResponse, APIError> {
    apiClient.sendURLSessionRequest(for: SearchMoviesRequest(page: page, query: query))
  }
}

struct MovieListResponse: Codable {
  let results: [Movie]
}
