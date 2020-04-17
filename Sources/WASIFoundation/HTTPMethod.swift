//
//  HTTPMethod.swift
//  SwiftFoundation
//
//  Created by Alsey Coleman Miller on 6/29/15.
//  Copyright © 2015 PureSwift.
//

public extension HTTP {
  /// HTTP Method.
  enum Method: String {
    case GET
    case PUT
    case DELETE
    case POST
    case OPTIONS
    case HEAD
    case TRACE
    case CONNECT
    case PATCH

    init() { self = .GET }
  }
}
