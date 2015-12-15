//
//  DateComponentsTest.swift
//  SwiftFoundation
//
//  Created by David Ask on 07/12/15.
//  Copyright © 2015 PureSwift. All rights reserved.
//

import XCTest
import SwiftFoundation

class DateComponentsTest : XCTestCase {
    func testMakeMyBirthDay() {
        
        var dateComponents = DateComponents()
        dateComponents.year = 1987
        dateComponents.month = 10
        dateComponents.dayOfMonth = 10
        
        let assertionDate = Date(timeIntervalSince1970: 560822400)
        let madeDate = dateComponents.date
        
        print(assertionDate, madeDate)
        
        XCTAssert(assertionDate == madeDate)
        
    }
}