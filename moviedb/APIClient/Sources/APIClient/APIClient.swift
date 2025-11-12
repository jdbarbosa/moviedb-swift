//
//  APIError.swift
//  APIClient
//
//  Created by Joao Barbosa on 24/04/2025.
//

import Foundation
import Combine

public protocol APIClient {

  var baseUrl: String { get }

  var decoder: JSONDecoder { get }

  /// Starts a URLSessionDataTask using the request for the corresponding APIResource.
  ///
  /// - Parameters:
  ///   - resource: APIResource defining some remote resource.
  /// - Returns: AnyPublisher for the corresponding resource, or nil.
  func sendURLSessionRequest<T: APIRequest>(for resource: T) -> AnyPublisher<T.Response, APIError>
}

extension APIClient {

  public func sendURLSessionRequest<T: APIRequest>(for resource: T) -> AnyPublisher<T.Response, APIError> {

    guard let request = resource.buildRequest(withBaseUrl: URL(string: self.baseUrl)) else {
      print("Bad url")
      return Fail(error: APIError.client).eraseToAnyPublisher()
    }
    print("URL: \(request.url?.absoluteString ?? "")")
    return URLSession.shared.dataTaskPublisher(for: request)
      .mapError { _ in APIError.network }
      .map { $0.data }
      .decode(type: T.Response.self, decoder: JSONDecoder())
      .mapError { error in
        print(error.localizedDescription)
        return APIError.decoding
      }
      .eraseToAnyPublisher()
  }
}

public final class MovieDatabaseAPIClient: APIClient {
  public var baseUrl = "https://api.themoviedb.org/3"

  public var decoder = JSONDecoder()

  public init() {}

}

