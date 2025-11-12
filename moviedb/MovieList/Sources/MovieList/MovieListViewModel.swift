//
//  MovieListViewModel.swift
//  moviedb
//
//  Created by Joao Barbosa on 23/04/2025.
//

import Combine
import Foundation
import SwiftUI
import Protocols
import Combine
import Models

final class MovieListViewModel: ObservableObject, ViewModel {

  typealias ViewControllerType = MovieListViewController

  private var cancellables = Set<AnyCancellable>()

  private let router: MovieListRouter
  private let repository: MovieListRepository

  @Published private(set) var movies: [Movie] = []
  private var page: Int = 0

  private(set) var isLoading: Bool = false
  private(set) var error: Error?

  init(
    router: MovieListRouter,
    repository: MovieListRepository
  ) {
    self.router = router
    self.repository = repository
  }

  func fetchMovies(page: Int) {
    repository.popularMovies(page: page)
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
          self.error = error
          print("Error fetching movies: \(error)")
        case .finished:
          break
        }
      }, receiveValue: { [weak self] response in
        self?.movies += response.results
        self?.page = page
      })
      .store(in: &cancellables)
  }

  @MainActor func movieWasTapped(_ movie: Movie) {
    router.routeToMovieDetails(movie: movie)
  }

  func triggerNewPageFetch() {
    fetchMovies(page: self.page + 1)
  }
}
