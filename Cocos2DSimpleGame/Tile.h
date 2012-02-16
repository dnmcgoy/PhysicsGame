//
//  Tile.h
//  PhysicsGame
//
//  Created by David Hansen on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vector2.h"
#import "Wall.h"

#define TILE_SIZE 40

@interface Tile : NSObject

-(id)initAtPosition:(Vector2*)position
           withWall:(Wall*)wall;

-(Vector2*)getNormalToWall;
-(Wall*)getWallWithAbsolutePosition;
-(NSComparisonResult)compare:(Tile*)other;

@property (nonatomic, retain) Vector2* position; // position of the bottom left corner
@property (nonatomic, retain) Wall* wall; // wall location is relative to tile position

@end
