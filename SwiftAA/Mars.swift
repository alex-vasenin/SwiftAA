//
//  Mars.swift
//  SwiftAA
//
//  Created by Cédric Foellmi on 19/06/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Foundation

public struct Mars: Planet {
    var julianDay: JulianDay
    var eclipticObject: KPCEclipticObject { return .Mars }
    var planet: KPCPlanetaryObject { return .MARS }
    
    init(julianDay: JulianDay) {
        self.julianDay = julianDay
    }
}
