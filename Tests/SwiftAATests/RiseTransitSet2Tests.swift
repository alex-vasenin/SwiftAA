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
    let moscow = GeographicCoordinates(positivelyWestwardLongitude: -37.615559, latitude: 55.752220)
    let accuracy = Minute(2.0).inJulianDays
    
    func testVenusAtBoston1988() { // See AA p.103
        let startDay = JulianDay(year: 1988, month: 3, day: 20)
        let endDay = JulianDay(year: 1988, month: 3, day: 21)
        let events = RiseTransitSet2.calculate(startDay: startDay, endDay: endDay,
                                               object: .VENUS, geographicCoordinates: boston,
                                               apparentRiseSetAltitude: Degree(-0.5667))
        
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
    
    func testVenusAtBoston2017() { // See http://aa.usno.navy.mil/data/docs/mrst.php
        let startDay = JulianDay(year: 2017, month: 3, day: 20)
        let endDay = JulianDay(year: 2017, month: 3, day: 21)
        let events = RiseTransitSet2.calculate(startDay: startDay, endDay: endDay,
                                               object: .VENUS, geographicCoordinates: boston,
                                               apparentRiseSetAltitude: Degree(-0.5667))
        
        let rises = events.filter { $0.type == .Rise }
        XCTAssert(rises.count == 1)
        let expectedRise = JulianDay(year: 2017, month: 03, day: 20, hour: 10, minute: 24)
        AssertEqual(rises.first!.julianDay, expectedRise, accuracy: accuracy)
        
        let transits = events.filter { $0.type == .SouthernTransit }
        XCTAssert(transits.count == 1)
        let expectedTransit = JulianDay(year: 2017, month: 03, day: 20, hour: 17, minute: 06)
        AssertEqual(transits.first!.julianDay, expectedTransit, accuracy: accuracy)
        
        let sets = events.filter { $0.type == .Set }
        XCTAssert(sets.count == 1)
        let expectedSet = JulianDay(year: 2017, month: 03, day: 20, hour: 23, minute: 48)
        AssertEqual(sets.first!.julianDay, expectedSet, accuracy: accuracy)
    }
    
    func testVenusAtMoscow2016() { // Data from SkySafari
        let startDay = JulianDay(year: 2016, month: 12, day: 27)
        let endDay = JulianDay(year: 2016, month: 12, day: 28)
        let events = RiseTransitSet2.calculate(startDay: startDay, endDay: endDay,
                                               object: .VENUS, geographicCoordinates: moscow,
                                               apparentRiseSetAltitude: Degree(-0.5667))
        
        let rises = events.filter { $0.type == .Rise }
        XCTAssert(rises.count == 1)
        let expectedRise = JulianDay(year: 2016, month: 12, day: 27, hour: 8, minute: 18, second: 13)
        AssertEqual(rises.first!.julianDay, expectedRise, accuracy: accuracy)
        
        let transits = events.filter { $0.type == .SouthernTransit }
        XCTAssert(transits.count == 1)
        let expectedTransit = JulianDay(year: 2016, month: 12, day: 27, hour: 12, minute: 45, second: 0)
        AssertEqual(transits.first!.julianDay, expectedTransit, accuracy: accuracy)
        
        let sets = events.filter { $0.type == .Set }
        XCTAssert(sets.count == 1)
        let expectedSet = JulianDay(year: 2016, month: 12, day: 27, hour: 17, minute: 12, second: 50)
        AssertEqual(sets.first!.julianDay, expectedSet, accuracy: accuracy)
    }
}
