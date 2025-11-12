//
//  PopularMovies.swift
//  MovieList
//
//  Created by Joao Barbosa on 30/04/2025.
//

import APIClient
import Foundation

final class SearchMoviesRequest: APIRequest {

  typealias Response = MovieListResponse

    var httpRequestMethod: HTTPRequestMethod = .get
    var path: String

    var additionalHeaders: [String : String]?
    var httpBody: Data?
    var queryItems: [URLQueryItem]?

  init(page: Int, query: String) {
    self.path = "/search/movie"
    self.queryItems = [
      URLQueryItem(name: "query", value: query),
      URLQueryItem(name: "page", value: "\(page)")
    ]
  }
}
