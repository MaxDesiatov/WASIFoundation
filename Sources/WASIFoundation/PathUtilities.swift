// Copyright (c) 2014 - 2016 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See http://swift.org/LICENSE.txt for license information
// See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//

private let validPathSeps: [Character] = ["/"]

extension String {
  internal var _startOfLastPathComponent: String.Index {
    precondition(!validPathSeps.contains(where: { hasSuffix(String($0)) }) && count > 1)

    let startPos = startIndex
    var curPos = endIndex

    // Find the beginning of the component
    while curPos > startPos {
      let prevPos = index(before: curPos)
      if validPathSeps.contains(self[prevPos]) {
        break
      }
      curPos = prevPos
    }
    return curPos
  }
}
