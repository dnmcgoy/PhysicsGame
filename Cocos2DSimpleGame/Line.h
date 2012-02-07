//
//  Line.h
//  PhysicsGame
//
//  Created by David Hansen on 2/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vector2.h"

@interface Line : NSObject

-(id) initWithVectorA:(Vector2*) vectorA
                 andB:(Vector2*) vectorB;

@property double A;
@property double B;
@property double C;
@property (nonatomic, retain) Vector2* v1;
@property (nonatomic, retain) Vector2* v2;

@end
