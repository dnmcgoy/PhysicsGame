//
//  VelocityPair.h
//  PhysicsGame
//
//  Created by David Hansen on 2/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vector2.h"

@interface VelocityPair : NSObject

@property (nonatomic, retain) Vector2* velocity;
@property double rotationalVelocity;

@end
