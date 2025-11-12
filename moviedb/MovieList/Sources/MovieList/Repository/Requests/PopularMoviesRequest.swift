//
//  PopularMovies.swift
//  MovieList
//
//  Created by Joao Barbosa on 30/04/2025.
//

import APIClient
import Foundation

final class PopularMoviesRequest: APIRequest {

  typealias Response = MovieListResponse

    var httpRequestMethod: HTTPRequestMethod = .get
    var path: String

    var additionalHeaders: [String : String]?
    var httpBody: Data?
    var queryItems: [URLQueryItem]?


  init(page: Int) {
    self.path = "/movie/popular"
    self.queryItems = [URLQueryItem(name: "page", value: "\(page)")]
  }
}
