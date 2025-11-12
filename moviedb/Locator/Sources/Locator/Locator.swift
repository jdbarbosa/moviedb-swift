import Foundation

/**
 Defines the ability of storing and lately resolving dependencies identified by a single key
 */
public protocol DependencyLocator: AnyObject {

  func resolve<T>(_ kind: Locator.Kind<T>) -> T

  func register<T>(_ kind: Locator.Kind<T>, _ value: T)
}

public class Locator: DependencyLocator {

  private var storage: [AnyHashable: Any] = [:]

  public struct Kind<T>: Hashable, CustomStringConvertible {
      let id: String
      public var description: String { id }

      public init(_ id: String = String(describing: T.self)) {
          self.id = id
      }
  }

  public func register<T>(_ kind: Kind<T>, _ value: T) {
    storage[kind] = value
  }

  /**
      Resolves a dependency based on its Kind

      Resolving a dependency generally means to execute previously registered closure in order to generate some `Dependency` object.

      If provided key was never registered, `nil` is immediately returned

      - Parameter key: the key to resolve.

      - Returns: a value resulting from dependency resolution.
   */

  public func resolve<T>(_ kind: Kind<T>) -> T {
      guard let value = storage[kind] as? T else {
          fatalError("Dependency not found for \(kind)")
      }
      return value
  }

  public init() {}

}
