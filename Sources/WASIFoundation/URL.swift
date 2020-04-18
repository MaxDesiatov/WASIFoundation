//
//  URL.swift
//  SwiftFoundation
//
//  Created by Alsey Coleman Miller on 6/29/15.
//  Copyright © 2015 PureSwift.
//

/// Encapsulates the components of an URL.
public struct URL: CustomStringConvertible {
  // MARK: - Properties

  public let scheme: String
  public let user: String?
  public let password: String?
  /// The host URL subcomponent (e.g. domain name, IP address)
  public let host: String?
  public let port: UInt?
  public let path: String?
  public let query: [(String, String)]?

  /// The fragment URL component (the part after a # symbol)
  public var fragment: String?

  // MARK: - Initialization

  public init(fileURLWithPath path: String) {
    scheme = "file://"
    user = nil
    password = nil
    host = nil
    port = nil
    self.path = path
    query = nil
    fragment = nil
  }

  /// Returns a valid URL string or ```nil```
  var urlString: String? {
    var stringValue = scheme + "://"

    if let user = user { stringValue += user }

    if let password = password { stringValue += ":\(password)" }

    if user != nil { stringValue += "@" }

    if let host = host { stringValue += host }

    if let port = port { stringValue += ":\(port)" }

    if let path = path { stringValue += "/\(path)" }

    if let query = query {
      stringValue += "?"

      for (index, queryItem) in query.enumerated() {
        let (name, value) = queryItem

        stringValue += name + "=" + value

        if index != query.count - 1 {
          stringValue += "&"
        }
      }
    }

    if let fragment = fragment { stringValue += "#\(fragment)" }

    return stringValue
  }

  public var description: String {
    let separator = " "

    var description = ""

    if let urlString = urlString {
      description += "URL: " + urlString + separator
    }

    description += "Scheme: " + scheme

    if let user = user {
      description += separator + "User: " + user
    }

    if let password = password {
      description += separator + "Password: " + password
    }

    if let host = host {
      description += separator + "Host: " + host
    }

    if let port = port {
      description += separator + "Port: " + "\(port)"
    }

    if let path = path {
      description += separator + "Path: " + path
    }

    if let query = query {
      var stringValue = ""

      for (index, queryItem) in query.enumerated() {
        let (name, value) = queryItem

        stringValue += name + "=" + value

        if index != query.count - 1 {
          stringValue += "&"
        }
      }

      description += separator + "Query: " + stringValue
    }

    if let fragment = fragment {
      description += separator + "Fragment: " + fragment
    }

    return description
  }

  func _pathByFixingSlashes(compress: Bool = true, stripTrailing: Bool = true) -> String? {
    guard let p = path else {
      return nil
    }

    if p == "/" {
      return p
    }

    var result = p
    if compress {
      let startPos = result.startIndex
      var endPos = result.endIndex
      var curPos = startPos

      while curPos < endPos {
        if result[curPos] == "/" {
          var afterLastSlashPos = curPos
          while afterLastSlashPos < endPos && result[afterLastSlashPos] == "/" {
            afterLastSlashPos = result.index(after: afterLastSlashPos)
          }
          if afterLastSlashPos != result.index(after: curPos) {
            result.replaceSubrange(curPos..<afterLastSlashPos, with: ["/"])
            endPos = result.endIndex
          }
          curPos = afterLastSlashPos
        } else {
          curPos = result.index(after: curPos)
        }
      }
    }
    if stripTrailing && result.hasSuffix("/") {
      result.remove(at: result.index(before: result.endIndex))
    }
    return result
  }

  public var lastPathComponent: String? {
    guard let fixedSelf = _pathByFixingSlashes() else {
      return nil
    }
    if fixedSelf.count <= 1 {
      return fixedSelf
    }

    return String(fixedSelf.suffix(from: fixedSelf._startOfLastPathComponent))
  }
}
