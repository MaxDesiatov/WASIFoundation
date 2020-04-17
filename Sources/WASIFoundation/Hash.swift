//
//  Hash.swift
//  SwiftFoundation
//
//  Created by Alsey Coleman Miller on 6/30/16.
//  Copyright © 2016 PureSwift.
//

/// Function for hashing data.
public func Hash(_ data: Data) -> Int {
  // more expensive than casting but that's not safe for large values.
  data.bytes.map { Int($0) }.reduce(0) { $0 ^ $1 }
}
