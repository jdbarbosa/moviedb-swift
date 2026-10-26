//
//  MovieListProvider.swift
//  MovieList
//
//  Created by Joao Barbosa on 30/04/2025.
//

import Locator
import APIClient
import UIKit

public protocol MovieListProvider {
    
    @MainActor func movieListViewController() -> UIViewController?
}

public struct MovieListProviderImpl: MovieListProvider {
    
    private let locator: any DependencyLocator
    private let factory: MovieListFactory
    
    @MainActor
    public init(locator: any DependencyLocator) {
        self.locator = locator
        self.factory = MovieListFactoryImpl(
            movieDetailProvider: locator.resolve(.movieDetailProvider)
        )
    }
    
    @MainActor public func movieListViewController() -> UIViewController? {
        factory.makeMovieListViewController(
            apiClient: locator.resolve(.apiClient)
        )
    }
}
