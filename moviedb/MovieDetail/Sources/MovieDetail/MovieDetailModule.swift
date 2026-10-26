

import Locator

public enum MovieDetailModule {
    /// Kinds this module resolves from the locator.
    public static let requiredKinds: [AnyLocatorKind] = [.apiClient, .movieDetailProvider]
}

extension Locator.Kind {
    public static var movieDetailProvider: Locator.Kind<MovieDetailProvider> { Locator.Kind("MovieDetailProvider") }
}

extension AnyLocatorKind {
  public static let movieDetailProvider = Locator.Kind<any MovieDetailProvider>.movieDetailProvider.erased
}

public extension MovieDetailModule {
    
    @MainActor
    static func registerServices(in locator: any DependencyLocator) {
        locator.register(.movieDetailProvider) { locator in
            MovieDetailProviderImpl(locator: locator)
        }
    }
}
