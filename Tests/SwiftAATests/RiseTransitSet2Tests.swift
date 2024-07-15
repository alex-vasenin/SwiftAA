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
    let accuracy = Minute(2).inJulianDays
    
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
    
    func testSunAtMoscow2016() { // Data from SkySafari
        let startDay = JulianDay(year: 2016, month: 12, day: 27)
        let endDay = JulianDay(year: 2016, month: 12, day: 28)
        let events = RiseTransitSet2.calculate(startDay: startDay, endDay: endDay, 
                                               object: .SUN, geographicCoordinates: moscow,
                                               apparentRiseSetAltitude: ArcMinute(-50).inDegrees)
        
        let rises = events.filter { $0.type == .Rise }
        XCTAssert(rises.count == 1)
        let expectedRise = JulianDay(year: 2016, month: 12, day: 27, hour: 5, minute: 58, second: 24)
        AssertEqual(rises.first!.julianDay, expectedRise, accuracy: accuracy)
        
        let transits = events.filter { $0.type == .SouthernTransit }
        XCTAssert(transits.count == 1)
        let expectedTransit = JulianDay(year: 2016, month: 12, day: 27, hour: 9, minute: 29, second: 41)
        AssertEqual(transits.first!.julianDay, expectedTransit, accuracy: accuracy)
        
        let sets = events.filter { $0.type == .Set }
        XCTAssert(sets.count == 1)
        let expectedSet = JulianDay(year: 2016, month: 12, day: 27, hour: 13, minute: 1, second: 6)
        AssertEqual(sets.first!.julianDay, expectedSet, accuracy: accuracy)
    }
    
    func testMoonAtMoscow2016() { // Data from SkySafari
        let jd = JulianDay(year: 2016, month: 12, day: 27)
        let events = RiseTransitSet2.calculateMoon(startDay: jd, endDay: jd + 1, geographicCoordinates: moscow)
        
        let rises = events.filter { $0.type == .Rise }
        XCTAssert(rises.count == 1)
        let expectedRise = JulianDay(year: 2016, month: 12, day: 27, hour: 3, minute: 38, second: 32)
        AssertEqual(rises.first!.julianDay, expectedRise, accuracy: accuracy)
        
        let transits = events.filter { $0.type == .SouthernTransit }
        XCTAssert(transits.count == 1)
        let expectedTransit = JulianDay(year: 2016, month: 12, day: 27, hour: 7, minute: 57, second: 43)
        AssertEqual(transits.first!.julianDay, expectedTransit, accuracy: accuracy)
        
        let sets = events.filter { $0.type == .Set }
        XCTAssert(sets.count == 1)
        let expectedSet = JulianDay(year: 2016, month: 12, day: 27, hour: 12, minute: 12, second: 46)
        AssertEqual(sets.first!.julianDay, expectedSet, accuracy: accuracy)

    }
    
    func testSiriusInCerroParanalChile() {
        let jd1 = JulianDay(year: 2018, month: 1, day: 1, hour: 12, minute: 0, second: 0)
        let jd2 = JulianDay(year: 2018, month: 6, day: 1, hour: 12, minute: 0, second: 0)
        let coords = EquatorialCoordinates(rightAscension: Hour(.plus, 6, 45, 9.25), 
                                           declination: Degree(.minus, 16, 42, 47.3))
        let paranal = GeographicCoordinates(positivelyWestwardLongitude: Degree(24.627222),
                                            latitude: Degree(-70.404167), altitude: 2400)
        let results1 = RiseTransitSet2.calculateStationary(startDay: jd1, endDay: jd1 + 1,
                                                           objectCoordinates: coords,
                                                           geographicCoordinates: paranal,
                                                           h0: ArcMinute(-34).inDegrees)
        XCTAssert(results1.filter { $0.type == .SouthernTransit } .count == 1)
        XCTAssert(results1.filter { $0.type == .Rise } .count == 1)
        XCTAssert(results1.filter { $0.type == .Set } .count == 1)
        
        let results2 = RiseTransitSet2.calculateStationary(startDay: jd2, endDay: jd2 + 1,
                                                           objectCoordinates: coords,
                                                           geographicCoordinates: paranal,
                                                           h0: ArcMinute(-34).inDegrees)
        
        XCTAssert(results2.filter { $0.type == .SouthernTransit } .count == 1)
        XCTAssert(results2.filter { $0.type == .Rise } .count == 1)
        XCTAssert(results2.filter { $0.type == .Set } .count == 1)
    }
    
    func testPolarisTtransitErrorAlwaysAbove() {
        let polaris = EquatorialCoordinates(rightAscension: Hour(.plus, 2, 31, 47.08),
                                            declination: Degree(.plus, 89, 15, 50.9))
        let jd = JulianDay(year: 2020, month: 9, day: 6)
        let usLocation = GeographicCoordinates(positivelyWestwardLongitude: Degree(.plus, 7, 46, 42),
                                               latitude: Degree(.plus, 49, 9, 3), altitude: 210)
        let results = RiseTransitSet2.calculateStationary(startDay: jd, endDay: jd+1,
                                                          objectCoordinates: polaris,
                                                          geographicCoordinates: usLocation, 
                                                          h0: ArcMinute(-34).inDegrees)
        XCTAssert(results.count == 2) // Only transits
        XCTAssertNil(results.first(where: { $0.type == .Rise }))
        XCTAssertNil(results.first(where: { $0.type == .Set }))
        let northTransit = results.first(where: { $0.type == .NorthernTransit })
        XCTAssertNotNil(northTransit)
        XCTAssert(northTransit?.isAboveHorizon == true)
        let southTransit = results.first(where: { $0.type == .SouthernTransit })
        XCTAssertNotNil(southTransit)
        XCTAssert(southTransit?.isAboveHorizon == true)
    }
    
    func testPolarisTtransitErrorAlwaysBelow() {
        let jd = JulianDay(year: 2020, month: 9, day: 6)
        let polaris = EquatorialCoordinates(rightAscension: Hour(.plus, 2, 31, 47.08),
                                            declination: Degree(.plus, 89, 15, 50.9))
        let paranal = GeographicCoordinates(positivelyWestwardLongitude: Degree(24.627222),
                                            latitude: Degree(-70.404167), altitude: 2400)
        let results = RiseTransitSet2.calculateStationary(startDay: jd, endDay: jd+1,
                                                          objectCoordinates: polaris,
                                                          geographicCoordinates: paranal,
                                                          h0: ArcMinute(-34).inDegrees)
        XCTAssert(results.count == 2)
        let northTransit = results.first(where: { $0.type == .NorthernTransit })
        XCTAssertNotNil(northTransit)
        XCTAssert(northTransit?.isAboveHorizon == false)
        let southTransit = results.first(where: { $0.type == .SouthernTransit })
        XCTAssertNotNil(southTransit)
        XCTAssert(southTransit?.isAboveHorizon == false)
    }
}
