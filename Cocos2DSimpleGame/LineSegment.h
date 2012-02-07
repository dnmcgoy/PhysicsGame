//
//  LineSegment.h
//  PhysicsGame
//
//  Created by David Hansen on 2/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Line.h"
#import "Vector2.h"

#define MICRO 0.001
#define EPSILON 0.01
#define MACRO 0.1

@interface LineSegment : NSObject

-(id)initWithVectorA:(Vector2*)vectorA
                andB:(Vector2*)vectorB;
-(BOOL)intersectsLine:(Line*)line;
-(BOOL)intersectsLineSegmentInclusive:(LineSegment*)other;
-(BOOL)intersectsLineSegmentExclusive:(LineSegment*)other;
-(BOOL)intersectsPoint:(Vector2*)point;
-(Vector2*)pointByIntersectionWithLine:(Line*)line;
-(Vector2*)pointByIntersectionWithLineSegment:(LineSegment*)other;	
-(double)distanceToPoint:(Vector2*)point;
-(BOOL)isAbove:(Vector2*)point;	
-(double)getYValueFromX:(double)x;
-(double)getXValueFromY:(double)y;

@property double A;
@property double B;
@property double C;
@property (nonatomic, retain) Vector2* v1;
@property (nonatomic, retain) Vector2* v2;

@end
