//
//  Range.swift
//  SwiftFoundation
//
//  Created by Alsey Coleman Miller on 3/31/16.
//  Copyright © 2016 PureSwift.
//

public extension Range where Bound: BinaryInteger {
  func isSubset(_ other: Range) -> Bool {
    lowerBound >= other.lowerBound
      && lowerBound <= other.upperBound
      && upperBound >= other.lowerBound
      && upperBound <= other.upperBound
  }
}
