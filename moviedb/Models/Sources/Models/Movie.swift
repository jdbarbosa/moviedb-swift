//
//  Movie.swift
//  MovieList
//
//  Created by Joao Barbosa on 30/04/2025.
//

public struct Movie: Codable {
  public let id: Int
  public let title: String
  public let posterPath: String?
  public let voteAverage: Double?
  public let releaseDate: String?
  public let overview: String?
//  let genreIds: [GenreId]?

  enum CodingKeys: String, CodingKey {
    case id
    case title
    case posterPath = "poster_path"
    case voteAverage = "vote_average"
    case releaseDate = "release_date"
    case overview
//    case genreIds = "genre_ids"
  }
}

public enum GenreId: Int, Codable {
  case action = 28
  case adventure = 12
  case animation = 16
  case comedy = 35
  case crime = 80
  case documentary = 99
  case drama = 18
  case family = 10751
  case fantasy = 14
  case history = 36
  case horror = 27
  case music = 10402
  case mystery = 96
  case romance = 10749
  case scienceFiction = 878
  case tvMovie = 10770
  case thriller = 53
  case war = 10752
  case western = 37
}
