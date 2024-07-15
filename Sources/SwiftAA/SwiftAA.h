//
//  SwiftAA.h
//  SwiftAA
//
//  Created by Cédric Foellmi on 20/12/15.
//  Copyright © 2015 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Project version number for SwiftAA.
FOUNDATION_EXPORT double SwiftAAVersionNumber;

//! Project version string for SwiftAA.
FOUNDATION_EXPORT const unsigned char SwiftAAVersionString[];


/* Swift and C++ inteoperability triggers generation of SwiftAA-Swift.h for Swift code to be used from C++. Even though
 we don't use Swift from C++, the file is generated. Without the following ObjC forward declarations the compiler
 throws "Unknown type name UIColor/NSColor/CLLocation" errors in generated SwiftAA-Swift.h */
@class UIColor;
@class NSColor;
@class CLLocation;
