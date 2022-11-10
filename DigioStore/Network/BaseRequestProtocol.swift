import Foundation

// MARK: - BaseRequestProtocol

protocol BaseRequestProtocol {
    var method: HTTPMethod { get }
    var path: String { get }
}

enum HTTPMethod: String {
  case post = "POST"
  case get = "GET"
  case put = "PUT"
  case patch = "PATCH"
  case delete = "DELETE"
}
