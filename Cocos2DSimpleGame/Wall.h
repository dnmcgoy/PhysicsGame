//
//  Wall.h
//  PhysicsGame
//
//  Created by David Hansen on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vector2.h"

@interface Wall : NSObject

-(id)initWithPointA:(Vector2*)pointA
          andPointB:(Vector2*)pointB;

-(Vector2*)getWallVector;
-(NSArray*)getPoints;

@property (nonatomic, retain) Vector2* w1;
@property (nonatomic, retain) Vector2* w2;

@end
