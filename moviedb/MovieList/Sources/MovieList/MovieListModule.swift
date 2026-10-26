//
//  MovieListModule.swift
//  MovieList
//
//  Created by Joao Barbosa on 29/05/2025.
//

import Locator

public enum MovieListModule {
    /// Kinds this module resolves from the locator.
    public static let requiredKinds: [AnyLocatorKind] = [.apiClient, .movieDetailProvider]
}

extension Locator.Kind {
    public static var movieListProvider: Locator.Kind<MovieListProvider> { Locator.Kind("MovieListProvider") }
}

extension AnyLocatorKind {
    public static let movieListProvider = Locator.Kind<any MovieListProvider>.movieListProvider.erased
}
public extension MovieListModule {
    
    @MainActor
    static func registerServices(in locator: any DependencyLocator) {
        locator.register(.movieListProvider) { locator in
            MovieListProviderImpl(locator: locator)
        }
    }
}
