//
//  Wall.m
//  PhysicsGame
//
//  Created by David Hansen on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Wall.h"

@implementation Wall

@synthesize w1;
@synthesize w2;

-(id)initWithPointA:(Vector2*)pointA
          andPointB:(Vector2*)pointB
{
    if (self = [super init])
    {
        self.w1 = pointA;
        self.w2 = pointB;
    }
    
    return self;
}

-(Vector2*)getWallVector
{
    return [self.w2 vectorBySubtractingVector:self.w1];
}

-(NSArray*)getPoints
{
    return [NSArray arrayWithObjects:self.w1, self.w2, nil];
}

@end
