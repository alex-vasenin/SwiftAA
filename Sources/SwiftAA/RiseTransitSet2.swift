//
//  RiseTransitSet2.swift
//  SwiftAA
//
//  Created by Alexander Vasenin on 14/07/24.
//  Copyright © 2024 onekiloparsec. All rights reserved.
//

import Foundation
import AABridge

/// Implementation for the algorithms which obtain the Rise, Transit and Set times (revised version)
public struct RiseTransitSet2 {
    public static func eventsForPlanet(_ planet: OtherPlanet,
                                       dateInterval: JulianDayInterval,
                                       iterationStep: Day = defaultIterationStep,
                                       observerLocation: GeographicCoordinates,
                                       apparentRiseSetAltitude: Degree = defaultRiseSetAltitude,
                                       highPrecision: Bool = false) -> [Event] {
        let events = CAARiseTransitSet2.Calculate(dateInterval.start.value,
                                                  dateInterval.end.value,
                                                  planet.rawValue,
                                                  observerLocation.longitude.value,
                                                  observerLocation.latitude.value,
                                                  apparentRiseSetAltitude.value,
                                                  iterationStep.value,
                                                  highPrecision)
        return events.compactMap { Event(rawValue: $0) }
    }
    
    public typealias SunEvents = (events: [Event], twilights: [Twilight])
    
    public static func eventsForSun(dateInterval: JulianDayInterval,
                                    iterationStep: Day = defaultIterationStep,
                                    observerLocation: GeographicCoordinates,
                                    apparentRiseSetAltitude: Degree = defaultSunRiseSetAltitude,
                                    highPrecision: Bool = false) -> SunEvents {
        let events = CAARiseTransitSet2.Calculate(dateInterval.start.value,
                                                  dateInterval.end.value,
                                                  .SUN,
                                                  observerLocation.longitude.value,
                                                  observerLocation.latitude.value,
                                                  apparentRiseSetAltitude.value,
                                                  iterationStep.value,
                                                  highPrecision)
        let riseSetsTransits = events.compactMap { Event(rawValue: $0) }
        let twilights = events.compactMap { Twilight(rawValue: $0) }
        return (riseSetsTransits, twilights)
    }
    
    public static func eventsForMoon(dateInterval: JulianDayInterval,
                                     iterationStep: Day = defaultIterationStep,
                                     observerLocation: GeographicCoordinates,
                                     refractionAtHorizon: Degree = defaultRiseSetAltitude,
                                     algorithm: MoonAlgorithm = .meeusTruncated) -> [Event] {
        let events = CAARiseTransitSet2.CalculateMoon(dateInterval.start.value,
                                                      dateInterval.end.value,
                                                      observerLocation.longitude.value,
                                                      observerLocation.latitude.value,
                                                      refractionAtHorizon.value,
                                                      iterationStep.value,
                                                      algorithm.rawValue)
        return events.compactMap { Event(rawValue: $0) }
    }
    
    public static func eventsForStationaryObject(at objectCoordinates: EquatorialCoordinates,
                                                 dateInterval: JulianDayInterval,
                                                 iterationStep: Day = defaultIterationStep,
                                                 observerLocation: GeographicCoordinates,
                                                 apparentRiseSetAltitude: Degree = defaultRiseSetAltitude) -> [Event] {
        let events = CAARiseTransitSet2.CalculateStationary(dateInterval.start.value,
                                                            dateInterval.end.value,
                                                            objectCoordinates.alpha.value,
                                                            objectCoordinates.delta.value,
                                                            observerLocation.longitude.value,
                                                            observerLocation.latitude.value,
                                                            apparentRiseSetAltitude.value,
                                                            iterationStep.value)
        return events.compactMap { Event(rawValue: $0) }
    }
    
    /// Geometric altitude of a small body at the time of apparent rising or setting, see p.102 of AA.
    public static let defaultRiseSetAltitude = ArcMinute(-34).inDegrees
    /// Geometric altitude of the center of the Sun at the time of apparent rising or setting, see p.102 of AA.
    public static let defaultSunRiseSetAltitude = ArcMinute(-50).inDegrees
    /// Approximately 0.007 days (AA+ default)
    public static let defaultIterationStep = Minute(10).inDays
}

extension RiseTransitSet2 {
    // For unclear reason Cxx interop doesn't let name it just `Planet`
    public enum OtherPlanet {
        case mercury
        case venus
        case mars
        case jupiter
        case saturn
        case uranus
        case neptune
        
        var rawValue: CAARiseTransitSet2.Object {
            switch self {
            case .mercury: return .MERCURY
            case .venus: return .VENUS
            case .mars: return .MARS
            case .jupiter: return .JUPITER
            case .saturn: return .SATURN
            case .uranus: return .URANUS
            case .neptune: return .NEPTUNE
            }
        }
    }
    
    public enum MoonAlgorithm {
        case meeusTruncated
        case elp2000
        
        var rawValue: CAARiseTransitSet2.MoonAlgorithm {
            switch self {
            case .meeusTruncated: return .MeeusTruncated
            case .elp2000: return .ELP2000
            }
        }
    }
    
    typealias RawDetails = CAARiseTransitSetDetails2
    
    public struct Event {
        /// The type of the event which has occurred
        public var kind: Kind
        /// When the event occurred in TT
        public var time: JulianDay
        /// Applicable for rise or sets only, this will be the bearing (degrees west of south) of the event
        public var bearing: Degree?
        /// For transits only, this will contain the geometric altitude in degrees of the center of the object not including correction for refraction
        public var geometricAltitude: Degree?
        /// For transits only, this will be true if the transit is visible
        public var isAboveHorizon: Bool?
        
        init?(rawValue: RawDetails) {
            guard let kind = Kind(rawValue: rawValue.type) else { return nil }
            self.kind = kind
            self.time = JulianDay(rawValue.JD)
            self.bearing = kind.isRiseOrSet ? Degree(rawValue.Bearing) : nil
            self.geometricAltitude = kind.isTransit ? Degree(rawValue.GeometricAltitude) : nil
            self.isAboveHorizon = kind.isTransit ? rawValue.bAboveHorizon : nil
        }
        
        public enum Kind: Equatable {
            case rise
            case set
            /// Southern means that bearing is 180° (see CAARiseTransitSet2::AddEvents implementation)
            case southernTransit
            /// Northern means that bearing is 0° (see CAARiseTransitSet2::AddEvents implementation)
            case northernTransit
            
            public var isTransit: Bool { self == .southernTransit || self == .northernTransit }
            public var isRiseOrSet: Bool { self == .rise || self == .set }
            
            init?(rawValue: RawDetails.`Type`) {
                switch rawValue {
                case .Rise: self = .rise
                case .Set: self = .set
                case .SouthernTransit: self = .southernTransit
                case .NorthernTransit: self = .northernTransit
                default: return nil
                }
            }
        }
    }
    
    public struct Twilight: Equatable {
        /// The type of the twilight which has occurred
        public var kind: Kind
        /// When the event occurred in TT
        public var time: JulianDay
        
        init?(rawValue: RawDetails) {
            guard let kind = Kind(rawValue: rawValue.type) else { return nil }
            self.kind = kind
            self.time = JulianDay(rawValue.JD)
        }
        
        public enum Kind: Equatable {
            case civilDusk
            case nauticalDusk
            case astronomicalDusk
            case astronomicalDawn
            case nauticalDawn
            case civilDawn
            
            init?(rawValue: RawDetails.`Type`) {
                switch rawValue {
                case .CivilDusk: self = .civilDusk
                case .NauticalDusk: self = .nauticalDusk
                case .AstronomicalDusk: self = .astronomicalDusk
                case .AstronomicalDawn: self = .astronomicalDawn
                case .NauticalDawn: self = .nauticalDawn
                case .CivilDawn: self = .civilDawn
                default: return nil
                }
            }
        }
    }
}
