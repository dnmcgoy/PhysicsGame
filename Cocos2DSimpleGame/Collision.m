//
//  Collision.m
//  PhysicsGame
//
//  Created by David Hansen on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Collision.h"

@implementation Collision

@synthesize collisions;
@synthesize normals;
@synthesize corrections;

-(id)init
{
    if (self = [super init])
    {
        collisions = [[NSMutableArray alloc] init];
        normals = [[NSMutableArray alloc] init];
        corrections = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(BOOL)isValidCollision
{
    return !(self.collisions == nil ||
             self.normals == nil ||
             self.corrections == nil ||
             [self.collisions count] == 0 ||
             [self.normals count] == 0 ||
             [self.corrections count] == 0 ||
             [collisions count] != [normals count] ||
             [normals count] != [corrections count]);
        
}

@end
