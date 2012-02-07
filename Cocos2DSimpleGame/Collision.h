//
//  Collision.h
//  PhysicsGame
//
//  Created by David Hansen on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Collision : NSObject

-(BOOL)isValidCollision;

@property (nonatomic, retain) NSMutableArray* collisions;
@property (nonatomic, retain) NSMutableArray* normals;
@property (nonatomic, retain) NSMutableArray* corrections;

@end
