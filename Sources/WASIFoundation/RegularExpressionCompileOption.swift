//
//  RegularExpressionCompileOption.swift
//  SwiftFoundation
//
//  Created by Alsey Coleman Miller on 8/9/15.
//  Copyright © 2015 PureSwift.
//

#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
import Darwin.C
#else
import Glibc
#endif

public extension RegularExpression {
  /// POSIX Regular Expression Compilation Options
  enum CompileOption: Int32, BitMaskOption {
    /// Do not differentiate case.
    case caseInsensitive

    /// Use POSIX Extended Regular Expression syntax when interpreting regular expression.
    /// If not set, POSIX Basic Regular Expression syntax is used.
    case extendedSyntax

    /// Report only success/fail.
    case noSub

    /** Treat a newline in string as dividing string into multiple lines, so that ```$``` can match
     before the newline and ```^``` can match after. Also, don’t permit ```.``` to match a newline,
     and don’t permit ```[^…]``` to match a newline.
      Otherwise, newline acts like any other ordinary character.
     */
    case newLine

    public init?(rawValue: POSIXRegularExpression.FlagBitmask) {
      switch rawValue {
      case REG_ICASE: self = .caseInsensitive
      case REG_EXTENDED: self = .extendedSyntax
      case REG_NOSUB: self = .noSub
      case REG_NEWLINE: self = .newLine

      default: return nil
      }
    }

    public var rawValue: POSIXRegularExpression.FlagBitmask {
      switch self {
      case .caseInsensitive: return REG_ICASE
      case .extendedSyntax: return REG_EXTENDED
      case .noSub: return REG_NOSUB
      case .newLine: return REG_NEWLINE
      }
    }
  }
}

public let REG_EXTENDED: Int32 = 1

public let REG_ICASE: Int32 = (REG_EXTENDED << 1)

public let REG_NEWLINE: Int32 = (REG_ICASE << 1)

public let REG_NOSUB: Int32 = (REG_NEWLINE << 1)
