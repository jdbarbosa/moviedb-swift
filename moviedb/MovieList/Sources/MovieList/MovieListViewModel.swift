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
	private let querySubject = CurrentValueSubject<String, Never>("")
	private let queryPublisher: AnyPublisher<String, Never>

  private(set) var isLoading: Bool = false
  private(set) var error: Error?

  init(
    router: MovieListRouter,
    repository: MovieListRepository
  ) {
		let scheduler: DispatchQueue = .main
    self.router = router
    self.repository = repository
		
		self.queryPublisher = querySubject
			.removeDuplicates()                       // "a" -> "a " is not a new query
			.debounce(for: .milliseconds(500), scheduler: scheduler)
			.removeDuplicates()                       // "ab" -> "a" -> "ab" inside the window: no refetch
			.eraseToAnyPublisher()
		
		self.queryPublisher
			.receive(on: DispatchQueue.main)
			.sink { [weak self] query in
				guard let self = self else { return }
				if query.isEmpty { self.fetchMovies(page: 1) } else {
					self.searchMovies(query: query)
				}
			}
			.store(in: &cancellables)
	}

  func fetchMovies(page: Int) {
    repository.popularMovies(page: page)
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { [weak self] completion in
				guard let self = self else { return }
        switch completion {
        case .failure(let error):
          self.error = error
          print("Error fetching movies: \(error)")
        case .finished:
          break
        }
      }, receiveValue: { [weak self] response in
				guard let self = self else { return }
				if page == 1 {
					self.movies = response.results
				} else {
					self.movies += response.results
				}
        self.page = page
      })
      .store(in: &cancellables)
  }

  @MainActor func movieWasTapped(_ movie: Movie) {
    router.routeToMovieDetails(movie: movie)
  }
	
	func didChangeQuery(query: String) {
		querySubject.send(query)
	}
	
	private func searchMovies(query: String) {
		let page = self.page
		self.isLoading = true
		repository.searchMovies(query: query, page: page)
			.receive(on: DispatchQueue.main)
			.sink(receiveCompletion: { [weak self] completion in
				guard let self = self else { return }
				self.isLoading = false
				switch completion {
				case .failure(let error):
					self.error = error
					print("Error fetching movies: \(error)")
				case .finished:
					break
				}
			}, receiveValue: { [weak self] response in
				guard let self = self else { return }
				self.movies = response.results
				self.page = page
			})
			.store(in: &cancellables)
	}

  func triggerNewPageFetch() {
    fetchMovies(page: self.page + 1)
  }
}
