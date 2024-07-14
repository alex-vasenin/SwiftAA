//
//  RiseTransitSet2.swift
//  SwiftAATests
//
//  Created by Alexander Vasenin on 14/07/24.
//  Copyright © 2024 onekiloparsec. All rights reserved.
//

import XCTest
import SwiftAA

class RiseTransitSet2Tests: XCTestCase {
    let boston = GeographicCoordinates(positivelyWestwardLongitude: 71.0833, latitude: 42.3333)
    let accuracy = Minute(2.0).inJulianDays
    
    func testVenusAtBoston1988() { // See AA p.103
        let startDay = JulianDay(year: 1988, month: 3, day: 20, hour: 0)
        let endDay = JulianDay(year: 1988, month: 3, day: 21, hour: 0)
        let events = RiseTransitSet2.calculate(startDay: startDay, endDay: endDay,
                                               object: .VENUS, geographicCoordinates: boston,
                                               apparentRiseSetAltitude: Degree(0.5667))
        
        let rises = events.filter { $0.type == .Rise }
        XCTAssert(rises.count == 1)
        let expectedRise = JulianDay(year: 1988, month: 03, day: 20, hour: 12, minute: 25)
        AssertEqual(rises.first!.julianDay, expectedRise, accuracy: accuracy)
        
        let transits = events.filter { $0.type == .SouthernTransit }
        XCTAssert(transits.count == 1)
        let expectedTransit = JulianDay(year: 1988, month: 03, day: 20, hour: 19, minute: 41)
        AssertEqual(transits.first!.julianDay, expectedTransit, accuracy: accuracy)
        
        let sets = events.filter { $0.type == .Set }
        XCTAssert(sets.count == 1)
        let expectedSet = JulianDay(year: 1988, month: 03, day: 20, hour: 2, minute: 55)
        AssertEqual(sets.first!.julianDay, expectedSet, accuracy: accuracy)
    }
}
