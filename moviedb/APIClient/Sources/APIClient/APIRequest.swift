//
//  APIRequest.swift
//  APIClient
//
//  Created by Joao Barbosa on 24/04/2025.
//

import Foundation

public protocol APIRequest {
  /// The associated response type to use when decoding the response from the API.
  associatedtype Response: Codable

  var additionalHeaders: [String: String]? { get }

  var httpBody: Data? { get }

  var httpRequestMethod: HTTPRequestMethod { get }

  var path: String { get }

  var queryItems: [URLQueryItem]? { get }
}

extension APIRequest {

  func buildRequest(withBaseUrl baseUrl: URL?) -> URLRequest? {
    guard let url = buildUrl(withBaseUrl: baseUrl) else {
      print("failed to build request for resource: \(String(describing: self))")
      return nil
    }
    var request = URLRequest(url: url)
    request.httpMethod = httpRequestMethod.rawValue
    request.httpBody = httpBody

    additionalHeaders?.forEach { key, value in
      request.setValue(value, forHTTPHeaderField: key)
    }

    return request
  }

  func buildUrl(withBaseUrl baseUrl: URL?) -> URL? {
    guard
      let baseUrl = baseUrl,
      var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)
    else {
      print("failed to build url for resource: \(String(describing: self))")
      return nil
    }
    components.path = baseUrl.path.appending(path)
    components.queryItems = (queryItems ?? []) + [URLQueryItem(name: "api_key", value: "181af7fcab50e40fabe2d10cc8b90e37")]
    return components.url
  }
}

public enum HTTPRequestMethod: String {
  case delete, get, patch, post, put
}

