//
//  Tile.m
//  PhysicsGame
//
//  Created by David Hansen on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Tile.h"

@implementation Tile

@synthesize position;
@synthesize wall;

-(id)initAtPosition:(Vector2*)newPosition
           withWall:(Wall*)newWall
{
    if (self = [super init])
    {
        self.position.x = newPosition.x * TILE_SIZE;
        self.position.y = newPosition.y * TILE_SIZE;
        self.wall.w1 = [newWall.w1 vectorByMultiplication:TILE_SIZE];
        self.wall.w2 = [newWall.w2 vectorByMultiplication:TILE_SIZE];
    }
    
    return self;
}

-(Vector2*)getNormalToWall
{
	Vector2* wallVector = [self.wall getWallVector];
	return [wallVector vectorByCrossProductWithNegativeZ];
}

-(Wall*)getWallWithAbsolutePosition
{
	return [[Wall alloc] initWithPointA:[self.wall.w1 vectorByAddingVector:position]
                              andPointB:[self.wall.w2 vectorByAddingVector:position]];
}

-(NSComparisonResult)compare:(Tile*)other 
{
    double leftValue;
    double rightValue;
    
    if(self.position.x != other.position.x)
    {
        leftValue = self.position.x;
        rightValue = other.position.x;
    }
	else
    {
		leftValue = self.position.y;
        rightValue = other.position.y;
    }
    
    NSNumber* left = [[NSNumber alloc] initWithDouble:leftValue];
    NSNumber* right = [[NSNumber alloc] initWithDouble:rightValue];
    
    return [left compare: right];
}


@end
