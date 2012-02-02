#import <Foundation/Foundation.h>
#import "RigidBody.h"

@interface Physics : NSObject

+(void)updatePositionOfRigidBody:(RigidBody*)rigidBody
                   overTimeDelta:(double)timeDelta;
+(void)updateVelocityOfRigidBody:(RigidBody*)rigidBody
                   overTimeDelta:(double)timeDelta;
+(void)updateGravityOfRigidBody:(RigidBody*)rigidBody
                  overTimeDelta:(double)timeDelta;

@end
