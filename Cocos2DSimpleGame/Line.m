//
//  Line.m
//  PhysicsGame
//
//  Created by David Hansen on 2/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Line.h"

@implementation Line

@synthesize A;
@synthesize B;
@synthesize C;
@synthesize v1;
@synthesize v2;

-(id) initWithVectorA:(Vector2*) vectorA
                 andB:(Vector2*) vectorB
{
    if (self = [super init])
    {
        self.v1 = vectorA;
        self.v2 = vectorB;
        self.A = v2.y - v1.y;
        self.B = v1.x - v2.x;
        self.C = A * v1.x + B * v1.y;
    }
    
    return self;
}

@end
