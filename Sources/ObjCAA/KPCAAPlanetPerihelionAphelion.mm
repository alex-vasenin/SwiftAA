//
//  KPCAAPlanetPerihelionAphelion.m
//  SwiftAA
//
//  Created by Cédric Foellmi on 10/07/15.
//  Licensed under the MIT License (see LICENSE file)
//

#import "KPCAAPlanetPerihelionAphelion.h"
#import "AAPlanetPerihelionAphelion.h"


long KPCAAPlanetPerihelionAphelion_MercuryK(double Year)
{
    return CAAPlanetPerihelionAphelion::MercuryK(Year);
}

double KPCAAPlanetPerihelionAphelion_MercuryPerihelion(double k)
{
    return CAAPlanetPerihelionAphelion::Mercury(k);
}

double KPCAAPlanetPerihelionAphelion_MercuryAphelion(double k)
{
    return CAAPlanetPerihelionAphelion::Mercury(k);
}


long KPCAAPlanetPerihelionAphelion_VenusK(double Year)
{
    return CAAPlanetPerihelionAphelion::VenusK(Year);
}

double KPCAAPlanetPerihelionAphelion_VenusPerihelion(double k)
{
    return CAAPlanetPerihelionAphelion::Venus(k);
}

double KPCAAPlanetPerihelionAphelion_VenusAphelion(double k)
{
    return CAAPlanetPerihelionAphelion::Venus(k);
}


long KPCAAPlanetPerihelionAphelion_EarthK(double Year)
{
    return CAAPlanetPerihelionAphelion::EarthK(Year);
}

double KPCAAPlanetPerihelionAphelion_EarthPerihelion(double k, bool barycentric)
{
    return CAAPlanetPerihelionAphelion::EarthPerihelion(k, barycentric);
}

double KPCAAPlanetPerihelionAphelion_EarthAphelion(double k, bool barycentric)
{
    return CAAPlanetPerihelionAphelion::EarthAphelion(k, barycentric);
}


long KPCAAPlanetPerihelionAphelion_MarsK(double Year)
{
    return CAAPlanetPerihelionAphelion::MarsK(Year);
}

double KPCAAPlanetPerihelionAphelion_MarsPerihelion(double k)
{
    return CAAPlanetPerihelionAphelion::Mars(k);
}

double KPCAAPlanetPerihelionAphelion_MarsAphelion(double k)
{
    return CAAPlanetPerihelionAphelion::Mars(k);
}


long KPCAAPlanetPerihelionAphelion_JupiterK(double Year)
{
    return CAAPlanetPerihelionAphelion::JupiterK(Year);
}

double KPCAAPlanetPerihelionAphelion_JupiterPerihelion(double k)
{
    return CAAPlanetPerihelionAphelion::Jupiter(k);
}

double KPCAAPlanetPerihelionAphelion_JupiterAphelion(double k)
{
    return CAAPlanetPerihelionAphelion::Jupiter(k);
}


long KPCAAPlanetPerihelionAphelion_SaturnK(double Year)
{
    return CAAPlanetPerihelionAphelion::SaturnK(Year);
}

double KPCAAPlanetPerihelionAphelion_SaturnPerihelion(double k)
{
    return CAAPlanetPerihelionAphelion::Saturn(k);
}

double KPCAAPlanetPerihelionAphelion_SaturnAphelion(double k)
{
    return CAAPlanetPerihelionAphelion::Saturn(k);
}


long KPCAAPlanetPerihelionAphelion_UranusK(double Year)
{
    return CAAPlanetPerihelionAphelion::UranusK(Year);
}

double KPCAAPlanetPerihelionAphelion_UranusPerihelion(double k)
{
    return CAAPlanetPerihelionAphelion::Uranus(k);
}

double KPCAAPlanetPerihelionAphelion_UranusAphelion(double k)
{
    return CAAPlanetPerihelionAphelion::Uranus(k);
}


long KPCAAPlanetPerihelionAphelion_NeptuneK(double Year)
{
    return CAAPlanetPerihelionAphelion::NeptuneK(Year);
}

double KPCAAPlanetPerihelionAphelion_NeptunePerihelion(double k)
{
    return CAAPlanetPerihelionAphelion::Neptune(k);
}

double KPCAAPlanetPerihelionAphelion_NeptuneAphelion(double k)
{
    return CAAPlanetPerihelionAphelion::Neptune(k);
}

double KPCAAPlanetPerihelionAphelion_K(double Year, KPCAAPlanetStrict planet)
{
    switch (planet) {
        case KPCAAPlanetStrictMercury:
            return KPCAAPlanetPerihelionAphelion_MercuryK(Year);
            break;
        case KPCAAPlanetStrictVenus:
            return KPCAAPlanetPerihelionAphelion_VenusK(Year);
            break;
        case KPCAAPlanetStrictEarth:
            return KPCAAPlanetPerihelionAphelion_EarthK(Year);
            break;
        case KPCAAPlanetStrictMars:
            return KPCAAPlanetPerihelionAphelion_MarsK(Year);
            break;
        case KPCAAPlanetStrictJupiter:
            return KPCAAPlanetPerihelionAphelion_JupiterK(Year);
            break;
        case KPCAAPlanetStrictSaturn:
            return KPCAAPlanetPerihelionAphelion_SaturnK(Year);
            break;
        case KPCAAPlanetStrictUranus:
            return KPCAAPlanetPerihelionAphelion_UranusK(Year);
            break;
        case KPCAAPlanetStrictNeptune:
            return KPCAAPlanetPerihelionAphelion_NeptuneK(Year);
            break;
        default:
            return 0;
            break;
    }
}

double KPCAAPlanetPerihelionAphelion_Perihelion(double k, KPCAAPlanetStrict planet)
{
    switch (planet) {
        case KPCAAPlanetStrictMercury:
            return KPCAAPlanetPerihelionAphelion_MercuryPerihelion(k);
            break;
        case KPCAAPlanetStrictVenus:
            return KPCAAPlanetPerihelionAphelion_VenusPerihelion(k);
            break;
        case KPCAAPlanetStrictEarth:
            return KPCAAPlanetPerihelionAphelion_EarthPerihelion(k, true);
            break;
        case KPCAAPlanetStrictMars:
            return KPCAAPlanetPerihelionAphelion_MarsPerihelion(k);
            break;
        case KPCAAPlanetStrictJupiter:
            return KPCAAPlanetPerihelionAphelion_JupiterPerihelion(k);
            break;
        case KPCAAPlanetStrictSaturn:
            return KPCAAPlanetPerihelionAphelion_SaturnPerihelion(k);
            break;
        case KPCAAPlanetStrictUranus:
            return KPCAAPlanetPerihelionAphelion_UranusPerihelion(k);
            break;
        case KPCAAPlanetStrictNeptune:
            return KPCAAPlanetPerihelionAphelion_NeptunePerihelion(k);
            break;
        default:
            return 0;
            break;
    }
}

double KPCAAPlanetPerihelionAphelion_Aphelion(double k, KPCAAPlanetStrict planet)
{
    switch (planet) {
        case KPCAAPlanetStrictMercury:
            return KPCAAPlanetPerihelionAphelion_MercuryAphelion(k);
            break;
        case KPCAAPlanetStrictVenus:
            return KPCAAPlanetPerihelionAphelion_VenusAphelion(k);
            break;
        case KPCAAPlanetStrictEarth:
            return KPCAAPlanetPerihelionAphelion_EarthAphelion(k, true);
            break;
        case KPCAAPlanetStrictMars:
            return KPCAAPlanetPerihelionAphelion_MarsAphelion(k);
            break;
        case KPCAAPlanetStrictJupiter:
            return KPCAAPlanetPerihelionAphelion_JupiterAphelion(k);
            break;
        case KPCAAPlanetStrictSaturn:
            return KPCAAPlanetPerihelionAphelion_SaturnAphelion(k);
            break;
        case KPCAAPlanetStrictUranus:
            return KPCAAPlanetPerihelionAphelion_UranusAphelion(k);
            break;
        case KPCAAPlanetStrictNeptune:
            return KPCAAPlanetPerihelionAphelion_NeptuneAphelion(k);
            break;
        default:
            return 0;
            break;
    }
}

