//
//  VelocityPair.m
//  PhysicsGame
//
//  Created by David Hansen on 2/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VelocityPair.h"

@implementation VelocityPair

@synthesize velocity;
@synthesize rotationalVelocity;

-(id)init
{
    if (self = [super init])
    {
        velocity = [[Vector2 alloc] init];
        rotationalVelocity = 0;
    }
    
    return self;
}

@end
