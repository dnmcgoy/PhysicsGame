//
//  LineSegment.m
//  PhysicsGame
//
//  Created by David Hansen on 2/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LineSegment.h"

@implementation LineSegment

@synthesize A;
@synthesize B;
@synthesize C;
@synthesize v1;
@synthesize v2;

// Ax + By = C
-(id)initWithVectorA:(Vector2*) vectorA
                andB:(Vector2*) vectorB
{
    if (self = [super init])
    {
        self.v1 = vectorA;
        self.v2 = vectorB;
        self.A = self.v2.y - self.v1.y;
        self.B = self.v1.x - self.v2.x;
        self.C = self.A * self.v1.x + self.B * self.v1.y;
    }
    
    return self;
}

-(BOOL)intersectsLineSegmentInclusive:(LineSegment *)other
{
	if(MIN(v1.x, v2.x) - EPSILON > MAX(other.v1.x, other.v2.x)
       || MIN(v1.y, v2.y) - EPSILON > MAX(other.v1.y, other.v2.y)
       || MAX(v1.x, v2.x) + EPSILON < MIN(other.v1.x, other.v2.x)
       || MAX(v1.y, v2.y) + EPSILON < MIN(other.v1.y, other.v2.y))
    {
		return NO;
    }
    
	double det = A * other.B - other.A * B;
    
	if(det == 0)
    {
        return NO;
    }
	else
	{
        double x = ((other.B * C) - (B * other.C)) / det;
        double y = ((A * other.C) - (other.A * C)) / det;
        
		return (MIN(v1.x, v2.x) - EPSILON <= x && x <= MAX(v1.x, v2.x) + EPSILON
                && MIN(v1.y, v2.y) - EPSILON <= y && y <= MAX(v1.y, v2.y) + EPSILON
                && MIN(other.v1.x, other.v2.x) - EPSILON <= x && x <= MAX(other.v1.x, other.v2.x) + EPSILON
                && MIN(other.v1.y, other.v2.y) - EPSILON <= y && y <= MAX(other.v1.y, other.v2.y) + EPSILON);
    }
}

-(BOOL)intersectsLineSegmentExclusive:(LineSegment*)other
{
	if(MIN(v1.x, v2.x) - EPSILON > MAX(other.v1.x, other.v2.x)
       || MIN(v1.y, v2.y) - EPSILON > MAX(other.v1.y, other.v2.y)
       || MAX(v1.x, v2.x) + EPSILON < MIN(other.v1.x, other.v2.x)
       || MAX(v1.y, v2.y) + EPSILON < MIN(other.v1.y, other.v2.y))
	{
		return NO;
	}
    
	double det = A * other.B - other.A * B;
    
	if(det == 0)
	{
		return NO;
	}
	else
	{
        double x = ((other.B * C) - (B * other.C)) / det;
        double y = ((A * other.C) - (other.A * C)) / det;
        
		return (MIN(v1.x, v2.x) - MICRO <= x && x <= MAX(v1.x, v2.x) + MICRO
                && MIN(v1.y, v2.y) - MICRO <= y && y <= MAX(v1.y, v2.y) + MICRO
                && MIN(other.v1.x, other.v2.x) - MICRO <= x && x <= MAX(other.v1.x, other.v2.x) + MICRO
                && MIN(other.v1.y, other.v2.y) - MICRO <= y && y <= MAX(other.v1.y, other.v2.y) + MICRO);
    }
}

-(BOOL)intersectsPoint:(Vector2 *)point
{
	if(point.x < MIN(v1.x, v2.x) - EPSILON || point.x > MAX(v1.x, v2.x) + EPSILON
       || point.y < MIN(v1.y, v2.y) - EPSILON || point.y > MAX(v1.y, v2.y) + EPSILON)
		return NO;
    
	double newC = (A * point.x) + (B * point.y);
	bool result = (newC <= C + MACRO && newC >= C - MACRO);
    
	return result;
}

-(Vector2*)pointByIntersectionWithLineSegment:(LineSegment*)other
{
	double det = A * other.B - other.A * B;
    
	if(det == 0)
    {
		return nil;
    }
	else
	{
        double x = ((other.B * C) - (B * other.C)) / det;
        double y = ((A * other.C) - (other.A * C)) / det;
        
		if(MIN(v1.x, v2.x) - EPSILON <= x && x <= MAX(v1.x, v2.x) + EPSILON
           && MIN(v1.y, v2.y) - EPSILON <= y && y <= MAX(v1.y, v2.y) + EPSILON
           && MIN(other.v1.x, other.v2.x) - EPSILON <= x && x <= MAX(other.v1.x, other.v2.x) + EPSILON
           && MIN(other.v1.y, other.v2.y) - EPSILON <= y && y <= MAX(other.v1.y, other.v2.y) + EPSILON)
		{
            return [[Vector2 alloc] initWithX:x andY:y];
		}
		else
        {
            return nil;
        }
    }
}

-(BOOL)intersectsLine:(Line*)line
{
	double det = A * line.B - line.A * B;
    
	if(det == 0)
    {
        return NO;
    }
	else
	{
        double x = ((line.B * C) - (B * line.C)) / det;
        double y = ((A * line.C) - (line.A * C)) / det;
        
		return (MIN(v1.x, v2.x) - EPSILON <= x && x <= MAX(v1.x, v2.x) + EPSILON
                && MIN(v1.y, v2.y) - EPSILON <= y && y <= MAX(v1.y, v2.y) + EPSILON);
    }
}

-(Vector2*)pointByIntersectionWithLine:(Line*)line
{
	double det = A * line.B - line.A * B;
    
	if(det == 0)
    {
        return nil;
    }
	else
	{
        double x = ((line.B * C) - (B * line.C)) / det;
        double y = ((A * line.C) - (line.A * C)) / det;
        
		if(MIN(v1.x, v2.x) - EPSILON <= x && x <= MAX(v1.x, v2.x) + EPSILON
           && MIN(v1.y, v2.y) - EPSILON <= y && y <= MAX(v1.y, v2.y) + EPSILON)
		{
            return [[Vector2 alloc] initWithX:x andY:y];
		}
		else
        {
            return nil;
        }
    }
}

// This is not correct. This gives the distance to the entire line, not the segment
-(double)distanceToPoint:(Vector2*)point
{
	double numerator = (A * point.x) + (B * point.y) + C;
	double denomenator = pow(pow(A, 2) + pow(B, 2), 0.5);
	return numerator / denomenator;
}

-(BOOL)isAbove:(Vector2*)point
{
	return (((A * point.x) + (B * point.y) + C) < 0);
}

-(double)getYValueFromX:(double)x
{
	return (C - (A * x)) / B;
}

-(double)getXValueFromY:(double)y
{
	return (C - (B * y)) / A;
}

@end
