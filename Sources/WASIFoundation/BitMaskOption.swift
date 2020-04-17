//
//  BitMaskOption.swift
//  SwiftFoundation
//
//  Created by Alsey Coleman Miller on 7/22/15.
//  Copyright © 2015 PureSwift.
//

/// Bit mask that represents various options.
public protocol BitMaskOption: RawRepresentable {
  static func bitmask(options: [Self]) -> Self.RawValue
}

public extension BitMaskOption where Self.RawValue: BinaryInteger {
  static func bitmask<S: Sequence>(options: S) -> Self.RawValue where S.Iterator.Element == Self {
    return options.reduce(0) { mask, option in
      mask | option.rawValue
    }
  }
}

public extension Sequence where Self.Iterator.Element: BitMaskOption, Self.Iterator.Element.RawValue: BinaryInteger {
  func optionsBitmask() -> Self.Iterator.Element.RawValue {
    let array = filter { (_) -> Bool in true }

    return Self.Iterator.Element.bitmask(options: array)
  }
}
