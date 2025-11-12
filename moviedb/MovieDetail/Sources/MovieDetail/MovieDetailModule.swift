

import Locator

public enum MovieDetailModule {}

extension Locator.Kind {
  public static var movieDetailProvider: Locator.Kind<MovieDetailProvider> { Locator.Kind("MovieDetailProvider") }
}
public extension MovieDetailModule {
  static func registerServices(in locator: Locator) {
    let movieDetailProvider = MovieDetailProviderImpl(locator: locator)
    locator.register(.movieDetailProvider, movieDetailProvider)
  }
}
