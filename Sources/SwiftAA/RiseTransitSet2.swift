//
//  RiseTransitSet2.swift
//  SwiftAA
//
//  Created by Alexander Vasenin on 14/07/24.
//  Copyright © 2024 onekiloparsec. All rights reserved.
//

import Foundation
import AABridge

// Implementation for the algorithms which obtain the Rise, Transit and Set times (revised version)
public struct RiseTransitSet2 {
    public typealias EventType = CAARiseTransitSetDetails2.`Type`
    public typealias Object = CAARiseTransitSet2.Object
    public typealias MoonAlgorithm = CAARiseTransitSet2.MoonAlgorithm
    
    typealias RawDetails = CAARiseTransitSetDetails2
    
    public struct Details {
        // The type of the event which has occurred
        public var type: EventType
        // When the event occurred in TT
        public var julianDay: JulianDay
        // Applicable for rise or sets only, this will be the bearing (degrees west of south) of the event
        public var bearing: Degree?
        // For transits only, this will contain the geometric altitude in degrees of the center of the object not including correction for refraction
        public var geometricAltitude: Degree?
        // For transits only, this will be true if the transit is visible
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
    
    public static func calculate(startDay: JulianDay,
                                 endDay: JulianDay,
                                 object: Object,
                                 geographicCoordinates: GeographicCoordinates,
                                 apparentRiseSetAltitude: Degree,
                                 stepInterval: Minute = 10, // Approximately 0.007 days (AA+ default)
                                 highPrecision: Bool = false) -> [Details] {
        let result = CAARiseTransitSet2.Calculate(startDay.value,
                                                  endDay.value,
                                                  object,
                                                  geographicCoordinates.longitude.value,
                                                  geographicCoordinates.latitude.value,
                                                  apparentRiseSetAltitude.value,
                                                  stepInterval.inDays.value,
                                                  highPrecision)
        return result.map { Details(rawValue: $0) }
    }
}
