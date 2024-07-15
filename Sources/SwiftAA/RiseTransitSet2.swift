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
    public static func calculatePlanet(_ planet: OtherPlanet,
                                       within dateInterval: JulianDayInterval,
                                       observerLocation: GeographicCoordinates,
                                       apparentRiseSetAltitude: Degree = defaultRiseSetAltitude,
                                       stepInterval: Minute = defaultStepInterval,
                                       highPrecision: Bool = false) -> [Details] {
        let result = CAARiseTransitSet2.Calculate(dateInterval.start.value,
                                                  dateInterval.end.value,
                                                  planet.rawValue,
                                                  observerLocation.longitude.value,
                                                  observerLocation.latitude.value,
                                                  apparentRiseSetAltitude.value,
                                                  stepInterval.inDays.value,
                                                  highPrecision)
        return result.map { Details(rawValue: $0) }
    }
    
    public static func calculateSun(within dateInterval: JulianDayInterval,
                                    observerLocation: GeographicCoordinates,
                                    apparentRiseSetAltitude: Degree = defaultSunRiseSetAltitude,
                                    stepInterval: Minute = defaultStepInterval,
                                    highPrecision: Bool = false) -> [Details] {
        let result = CAARiseTransitSet2.Calculate(dateInterval.start.value,
                                                  dateInterval.end.value,
                                                  .SUN,
                                                  observerLocation.longitude.value,
                                                  observerLocation.latitude.value,
                                                  apparentRiseSetAltitude.value,
                                                  stepInterval.inDays.value,
                                                  highPrecision)
        return result.map { Details(rawValue: $0) }
    }
    
    public static func calculateMoon(within dateInterval: JulianDayInterval,
                                     observerLocation: GeographicCoordinates,
                                     refractionAtHorizon: Degree = defaultRiseSetAltitude,
                                     stepInterval: Minute = defaultStepInterval,
                                     algorithm: MoonAlgorithm = .MeeusTruncated) -> [Details] {
        let result = CAARiseTransitSet2.CalculateMoon(dateInterval.start.value,
                                                      dateInterval.end.value,
                                                      observerLocation.longitude.value,
                                                      observerLocation.latitude.value,
                                                      refractionAtHorizon.value,
                                                      stepInterval.inDays.value,
                                                      algorithm)
        return result.map { Details(rawValue: $0) }
    }
    
    public static func calculateStationaryObject(at objectCoordinates: EquatorialCoordinates,
                                                 within dateInterval: JulianDayInterval,
                                                 observerLocation: GeographicCoordinates,
                                                 apparentRiseSetAltitude: Degree = defaultRiseSetAltitude,
                                                 stepInterval: Minute = defaultStepInterval) -> [Details] {
        let result = CAARiseTransitSet2.CalculateStationary(dateInterval.start.value,
                                                            dateInterval.end.value,
                                                            objectCoordinates.alpha.value,
                                                            objectCoordinates.delta.value,
                                                            observerLocation.longitude.value,
                                                            observerLocation.latitude.value,
                                                            apparentRiseSetAltitude.value,
                                                            stepInterval.inDays.value)
        return result.map { Details(rawValue: $0) }
    }
    
    /// Geometric altitude of the center of the body at the time of apparent rising or setting, see p.102 of AA.
    public static let defaultRiseSetAltitude = ArcMinute(-34).inDegrees
    /// Geometric altitude of the center of the body at the time of apparent rising or setting, see p.102 of AA.
    public static let defaultSunRiseSetAltitude = ArcMinute(-50).inDegrees
    /// Approximately 0.007 days (AA+ default)
    public static let defaultStepInterval = Minute(10)
}

extension RiseTransitSet2 {
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
    
    public typealias EventType = CAARiseTransitSetDetails2.`Type`
    public typealias Object = CAARiseTransitSet2.Object
    public typealias MoonAlgorithm = CAARiseTransitSet2.MoonAlgorithm
    
    typealias RawDetails = CAARiseTransitSetDetails2
    
    public struct Details {
        /// The type of the event which has occurred
        public var type: EventType
        /// When the event occurred in TT
        public var julianDay: JulianDay
        /// Applicable for rise or sets only, this will be the bearing (degrees west of south) of the event
        public var bearing: Degree?
        /// For transits only, this will contain the geometric altitude in degrees of the center of the object not including correction for refraction
        public var geometricAltitude: Degree?
        /// For transits only, this will be true if the transit is visible
        public var isAboveHorizon: Bool?
        
        init(rawValue: RawDetails) {
            self.type = rawValue.type
            self.julianDay = JulianDay(rawValue.JD)
            let isRiseOrSet = type == .Rise || type == .Set
            self.bearing = isRiseOrSet ? Degree(rawValue.Bearing) : nil
            let isTransit = type == .NorthernTransit || type == .SouthernTransit
            self.geometricAltitude = isTransit ? Degree(rawValue.GeometricAltitude) : nil
            self.isAboveHorizon = isTransit ? rawValue.bAboveHorizon : nil
        }
    }
}
