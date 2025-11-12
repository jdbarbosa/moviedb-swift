//
//  MovieDetailViewModel.swift
//  MovieDetail
//
//  Created by Joao Barbosa on 30/05/2025.
//

import Foundation
import SwiftUI
import Protocols
import Combine
import Models

final class MovieDetailViewModel: ObservableObject, ViewModel {

  typealias ViewControllerType = MovieDetailViewController

  private var cancellables = Set<AnyCancellable>()
  let movie: Movie

  init(movie: Movie) {
    self.movie = movie
    print("https://image.tmdb.org/t/p/original" + (movie.posterPath ?? ""))
  }
}
