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
        let dateInterval = JulianDayInterval(start: JulianDay(year: 1988, month: 3, day: 20), duration: 1)
        let events = RiseTransitSet2.eventsForPlanet(.venus, dateInterval: dateInterval, observerLocation: boston)
        
        let rises = events.filter { $0.kind == .rise }
        XCTAssert(rises.count == 1)
        let expectedRise = JulianDay(year: 1988, month: 03, day: 20, hour: 12, minute: 25)
        AssertEqual(rises.first!.time, expectedRise, accuracy: accuracy)
        
        let transits = events.filter { $0.kind == .southernTransit }
        XCTAssert(transits.count == 1)
        let expectedTransit = JulianDay(year: 1988, month: 03, day: 20, hour: 19, minute: 41)
        AssertEqual(transits.first!.time, expectedTransit, accuracy: accuracy)
        
        let sets = events.filter { $0.kind == .set }
        XCTAssert(sets.count == 1)
        let expectedSet = JulianDay(year: 1988, month: 03, day: 20, hour: 2, minute: 55)
        AssertEqual(sets.first!.time, expectedSet, accuracy: accuracy)
    }
    
    func testVenusAtBoston2017() { // See http://aa.usno.navy.mil/data/docs/mrst.php
        let dateInterval = JulianDayInterval(start: JulianDay(year: 2017, month: 3, day: 20), duration: 1)
        let events = RiseTransitSet2.eventsForPlanet(.venus, dateInterval: dateInterval, observerLocation: boston)
        
        let rises = events.filter { $0.kind == .rise }
        XCTAssert(rises.count == 1)
        let expectedRise = JulianDay(year: 2017, month: 03, day: 20, hour: 10, minute: 24)
        AssertEqual(rises.first!.time, expectedRise, accuracy: accuracy)
        
        let transits = events.filter { $0.kind == .southernTransit }
        XCTAssert(transits.count == 1)
        let expectedTransit = JulianDay(year: 2017, month: 03, day: 20, hour: 17, minute: 06)
        AssertEqual(transits.first!.time, expectedTransit, accuracy: accuracy)
        
        let sets = events.filter { $0.kind == .set }
        XCTAssert(sets.count == 1)
        let expectedSet = JulianDay(year: 2017, month: 03, day: 20, hour: 23, minute: 48)
        AssertEqual(sets.first!.time, expectedSet, accuracy: accuracy)
    }
    
    func testVenusAtMoscow2016() { // Data from SkySafari
        let dateInterval = JulianDayInterval(start: JulianDay(year: 2016, month: 12, day: 27), duration: 1)
        let events = RiseTransitSet2.eventsForPlanet(.venus, dateInterval: dateInterval, observerLocation: moscow)
        
        let rises = events.filter { $0.kind == .rise }
        XCTAssert(rises.count == 1)
        let expectedRise = JulianDay(year: 2016, month: 12, day: 27, hour: 8, minute: 18, second: 13)
        AssertEqual(rises.first!.time, expectedRise, accuracy: accuracy)
        
        let transits = events.filter { $0.kind == .southernTransit }
        XCTAssert(transits.count == 1)
        let expectedTransit = JulianDay(year: 2016, month: 12, day: 27, hour: 12, minute: 45, second: 0)
        AssertEqual(transits.first!.time, expectedTransit, accuracy: accuracy)
        
        let sets = events.filter { $0.kind == .set }
        XCTAssert(sets.count == 1)
        let expectedSet = JulianDay(year: 2016, month: 12, day: 27, hour: 17, minute: 12, second: 50)
        AssertEqual(sets.first!.time, expectedSet, accuracy: accuracy)
    }
    
    func testSunAtMoscow2016() { // Data from SkySafari
        let dateInterval = JulianDayInterval(start: JulianDay(year: 2016, month: 12, day: 27), duration: 1)
        let result = RiseTransitSet2.eventsForSun(dateInterval: dateInterval, observerLocation: moscow)
        
        let rises = result.events.filter { $0.kind == .rise }
        XCTAssert(rises.count == 1)
        let expectedRise = JulianDay(year: 2016, month: 12, day: 27, hour: 5, minute: 58, second: 24)
        AssertEqual(rises.first!.time, expectedRise, accuracy: accuracy)
        
        let transits = result.events.filter { $0.kind == .southernTransit }
        XCTAssert(transits.count == 1)
        let expectedTransit = JulianDay(year: 2016, month: 12, day: 27, hour: 9, minute: 29, second: 41)
        AssertEqual(transits.first!.time, expectedTransit, accuracy: accuracy)
        
        let sets = result.events.filter { $0.kind == .set }
        XCTAssert(sets.count == 1)
        let expectedSet = JulianDay(year: 2016, month: 12, day: 27, hour: 13, minute: 1, second: 6)
        AssertEqual(sets.first!.time, expectedSet, accuracy: accuracy)
    }
    
    func testMoonAtMoscow2016() { // Data from SkySafari
        let dateInterval = JulianDayInterval(start: JulianDay(year: 2016, month: 12, day: 27), duration: 1)
        let events = RiseTransitSet2.eventsForMoon(dateInterval: dateInterval, observerLocation: moscow)
        
        let rises = events.filter { $0.kind == .rise }
        XCTAssert(rises.count == 1)
        let expectedRise = JulianDay(year: 2016, month: 12, day: 27, hour: 3, minute: 38, second: 32)
        AssertEqual(rises.first!.time, expectedRise, accuracy: accuracy)
        
        let transits = events.filter { $0.kind == .southernTransit }
        XCTAssert(transits.count == 1)
        let expectedTransit = JulianDay(year: 2016, month: 12, day: 27, hour: 7, minute: 57, second: 43)
        AssertEqual(transits.first!.time, expectedTransit, accuracy: accuracy)
        
        let sets = events.filter { $0.kind == .set }
        XCTAssert(sets.count == 1)
        let expectedSet = JulianDay(year: 2016, month: 12, day: 27, hour: 12, minute: 12, second: 46)
        AssertEqual(sets.first!.time, expectedSet, accuracy: accuracy)

    }
    
    func testSiriusInCerroParanalChile() {
        let coords = EquatorialCoordinates(rightAscension: Hour(.plus, 6, 45, 9.25),
                                           declination: Degree(.minus, 16, 42, 47.3))
        let paranal = GeographicCoordinates(positivelyWestwardLongitude: Degree(24.627222),
                                            latitude: Degree(-70.404167), altitude: 2400)
        
        let dateInterval1 = JulianDayInterval(start: JulianDay(year: 2018, month: 1, day: 1, hour: 12), duration: 1)
        let results1 = RiseTransitSet2.eventsForStationaryObject(at: coords, dateInterval: dateInterval1,
                                                                 observerLocation: paranal)
        XCTAssert(results1.filter { $0.kind == .southernTransit } .count == 1)
        XCTAssert(results1.filter { $0.kind == .rise } .count == 1)
        XCTAssert(results1.filter { $0.kind == .set } .count == 1)
        
        let dateInterval2 = JulianDayInterval(start: JulianDay(year: 2018, month: 6, day: 1, hour: 12), duration: 1)
        let results2 = RiseTransitSet2.eventsForStationaryObject(at: coords, dateInterval: dateInterval2,
                                                                 observerLocation: paranal)
        
        XCTAssert(results2.filter { $0.kind == .southernTransit } .count == 1)
        XCTAssert(results2.filter { $0.kind == .rise } .count == 1)
        XCTAssert(results2.filter { $0.kind == .set } .count == 1)
    }
    
    func testPolarisTtransitErrorAlwaysAbove() {
        let dateInterval = JulianDayInterval(start: JulianDay(year: 2020, month: 9, day: 6), duration: 1)
        let polaris = EquatorialCoordinates(rightAscension: Hour(.plus, 2, 31, 47.08),
                                            declination: Degree(.plus, 89, 15, 50.9))
        let usLocation = GeographicCoordinates(positivelyWestwardLongitude: Degree(.plus, 7, 46, 42),
                                               latitude: Degree(.plus, 49, 9, 3), altitude: 210)
        let results = RiseTransitSet2.eventsForStationaryObject(at: polaris, dateInterval: dateInterval,
                                                                observerLocation: usLocation)
        XCTAssert(results.allSatisfy({ $0.kind == .northernTransit }))
        XCTAssert(results.allSatisfy({ $0.isAboveHorizon == true }))
        XCTAssert(results.count == 2)
    }
    
    func testPolarisTtransitErrorAlwaysBelow() {
        let dateInterval = JulianDayInterval(start: JulianDay(year: 2020, month: 9, day: 6), duration: 1)
        let polaris = EquatorialCoordinates(rightAscension: Hour(.plus, 2, 31, 47.08),
                                            declination: Degree(.plus, 89, 15, 50.9))
        let paranal = GeographicCoordinates(positivelyWestwardLongitude: Degree(24.627222),
                                            latitude: Degree(-70.404167), altitude: 2400)
        let results = RiseTransitSet2.eventsForStationaryObject(at: polaris, dateInterval: dateInterval,
                                                                observerLocation: paranal)
        XCTAssert(results.allSatisfy({ $0.kind == .northernTransit }))
        XCTAssert(results.allSatisfy({ $0.isAboveHorizon == false }))
        XCTAssert(results.count == 2)
    }
    
    // See http://aa.usno.navy.mil/cgi-bin/aa_rstablew.pl?ID=AA&year=2017&task=4&place=&lon_sign=1&lon_deg=2&lon_min=21&lat_sign=1&lat_deg=48&lat_min=52&tz=0&tz_sign=-1
    // for a reference table for the 2017 year
    func testValidTwilightNorthernHemisphereWestLongitudeAgainstUSNOReference() {
        let paris = GeographicCoordinates(positivelyWestwardLongitude: Degree(.minus, 2, 21, 0.0),
                                          latitude: Degree(.plus, 48, 52, 0.0))
        
        let jan1 = JulianDayInterval(start: JulianDay(year: 2017, month: 1, day: 1), duration: 1)
        let eventsJan1 = RiseTransitSet2.eventsForSun(dateInterval: jan1, observerLocation: paris)
        AssertEqual(eventsJan1.twilights.first(where: { $0.kind == .astronomicalDawn })!.time,
                    JulianDay(year: 2017, month: 1, day: 1, hour: 5, minute: 48), accuracy: accuracy)
        AssertEqual(eventsJan1.twilights.first(where: { $0.kind == .astronomicalDusk })!.time,
                    JulianDay(year: 2017, month: 1, day: 1, hour: 18, minute: 00), accuracy: accuracy)
        
        let mar1 = JulianDayInterval(start: JulianDay(year: 2017, month: 3, day: 1), duration: 1)
        let eventsMar1 = RiseTransitSet2.eventsForSun(dateInterval: mar1, observerLocation: paris)
        AssertEqual(eventsMar1.twilights.first(where: { $0.kind == .astronomicalDawn })!.time,
                    JulianDay(year: 2017, month: 3, day: 1, hour: 4, minute: 48), accuracy: accuracy)
        AssertEqual(eventsMar1.twilights.first(where: { $0.kind == .astronomicalDusk })!.time,
                    JulianDay(year: 2017, month: 3, day: 1, hour: 19, minute: 19), accuracy: accuracy)
        
        let jun1 = JulianDayInterval(start: JulianDay(year: 2017, month: 6, day: 1), duration: 1)
        let eventsJun1 = RiseTransitSet2.eventsForSun(dateInterval: jun1, observerLocation: paris)
        AssertEqual(eventsJun1.twilights.first(where: { $0.kind == .astronomicalDawn })!.time,
                    JulianDay(year: 2017, month: 6, day: 1, hour: 0, minute: 44), accuracy: accuracy)
        AssertEqual(eventsJun1.twilights.first(where: { $0.kind == .astronomicalDusk })!.time,
                    JulianDay(year: 2017, month: 6, day: 1, hour: 22, minute: 56), accuracy: accuracy)
        
        let sep1 = JulianDayInterval(start: JulianDay(year: 2017, month: 9, day: 1), duration: 1)
        let eventsSep1 = RiseTransitSet2.eventsForSun(dateInterval: sep1, observerLocation: paris)
        AssertEqual(eventsSep1.twilights.first(where: { $0.kind == .astronomicalDawn })!.time,
                    JulianDay(year: 2017, month: 9, day: 1, hour: 3, minute: 11), accuracy: accuracy)
        AssertEqual(eventsSep1.twilights.first(where: { $0.kind == .astronomicalDusk })!.time,
                    JulianDay(year: 2017, month: 9, day: 1, hour: 20, minute: 28), accuracy: accuracy)
    }
    
    func testValidTwilightNorthernHemisphereAboveArticCircle() {
        let north = GeographicCoordinates(positivelyWestwardLongitude: Degree(.minus, 2, 21, 0.0),
                                          latitude: Degree(75.0))
        
        let winter = JulianDayInterval(start: JulianDay(year: 2017, month: 1, day: 30), duration: 1)
        let (winterEvents, _) = RiseTransitSet2.eventsForSun(dateInterval: winter, observerLocation: north)
        XCTAssert(winterEvents.filter { $0.kind.isRiseOrSet } .count == 0)
        XCTAssert(winterEvents.filter { $0.kind.isTransit } .count == 2)
        XCTAssert(winterEvents.filter { $0.kind.isTransit } .allSatisfy { $0.isAboveHorizon == false })
        
        // There is a bug in AA+ which make this test fail if we specify hour == 0 (notified the author)
        let summer = JulianDayInterval(start: JulianDay(year: 2017, month: 7, day: 30, hour: 1), duration: 1)
        let (summerEvents, _) = RiseTransitSet2.eventsForSun(dateInterval: summer, observerLocation: north)
        XCTAssert(summerEvents.filter { $0.kind.isRiseOrSet } .count == 0)
        XCTAssert(summerEvents.filter { $0.kind.isTransit } .count == 2)
        XCTAssert(summerEvents.filter { $0.kind.isTransit } .allSatisfy { $0.isAboveHorizon == true } )
    }
}
