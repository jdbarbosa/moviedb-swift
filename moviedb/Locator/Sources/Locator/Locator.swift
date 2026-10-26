import Foundation

/**
 Defines the ability of storing and lately resolving dependencies identified by a single key
 */
@MainActor
public protocol DependencyLocator: AnyObject {
    
    /// Registers a lazy factory. The closure runs on first `resolve` and its
    /// result is cached for subsequent calls.
    func register<T>(_ kind: Locator.Kind<T>, make: @escaping @MainActor (any DependencyLocator) -> T)
    
    /// Registers an already-built value.
    func register<T>(_ kind: Locator.Kind<T>, _ value: T)
    
    /// Returns the value for `kind`, building it on first use.
    /// Traps if nothing was registered for `kind`.
    func resolve<T>(_ kind: Locator.Kind<T>) -> T
    
    func isRegistered(_ kind: AnyLocatorKind) -> Bool
    
    /// Every kind in `required` that has no registration. Empty means OK.
    func missing(from required: [AnyLocatorKind]) -> [AnyLocatorKind]
    
    /// Traps unless every kind in `required` is registered.
    func verify(allOf required: [AnyLocatorKind])
}

@MainActor
public final class Locator: DependencyLocator {
    
    /// A typed key. `T` is the type `resolve` returns; `id` identifies the entry.
    public struct Kind<T>: Hashable, Sendable, CustomStringConvertible {
        public let id: String
        
        public init(_ id: String = String(describing: T.self)) {
            self.id = id
        }
        
        public var erased: AnyLocatorKind { AnyLocatorKind(id) }
        public var description: String { id }
    }
    
    private struct LazyEntry {
        let make: @MainActor (any DependencyLocator) -> Any
    }
    
    private enum Entry {
        case value(Any)
        case lazy(LazyEntry)
    }
    
    private var storage: [AnyLocatorKind: Entry] = [:]
    
    public init() {}
    
    public func register<T>(_ kind: Kind<T>, make: @escaping @MainActor (any DependencyLocator) -> T) {
        store(.lazy(LazyEntry(make: { make($0) })), for: kind)
    }
    
    public func register<T>(_ kind: Kind<T>, _ value: T) {
        store(.value(value), for: kind)
    }
    
    public func resolve<T>(_ kind: Kind<T>) -> T {
        let key = kind.erased
        guard let entry = storage[key] else {
            fatalError("Locator: no registration for \(kind). Registered: \(registeredIds)")
        }
        let raw: Any
        switch entry {
        case .value(let value):
            raw = value
        case .lazy(let lazy):
            raw = lazy.make(self)
            storage[key] = .value(raw)
        }
        guard let typed = raw as? T else {
            fatalError("Locator: registration for \(kind) is \(type(of: raw)), expected \(T.self)")
        }
        return typed
    }
    
    public func isRegistered(_ kind: AnyLocatorKind) -> Bool {
        storage[kind] != nil
    }
    
    public func missing(from required: [AnyLocatorKind]) -> [AnyLocatorKind] {
        required.filter { storage[$0] == nil }
    }
    
    public func verify(allOf required: [AnyLocatorKind]) {
        let missing = missing(from: required)
        precondition(missing.isEmpty, "Locator: missing registrations: \(missing)")
    }
    
    private func store<T>(_ entry: Entry, for kind: Kind<T>) {
        precondition(storage[kind.erased] == nil, "Locator: \(kind) is already registered")
        storage[kind.erased] = entry
    }
    
    private var registeredIds: [String] {
        storage.keys.map(\.id).sorted()
    }
}

/// A type-erased locator key. Used to declare a module's required
/// dependencies and to verify registrations without knowing the value type.
public struct AnyLocatorKind: Hashable, Sendable, CustomStringConvertible {
    public let id: String
    
    public init(_ id: String) {
        self.id = id
    }
    
    public var description: String { id }
}
