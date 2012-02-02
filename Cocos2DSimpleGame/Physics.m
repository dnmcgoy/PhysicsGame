#import "Physics.h"

@implementation Physics

+(void)updatePositionOfRigidBody:(RigidBody*)rigidBody
                   overTimeDelta:(double)timeDelta
{
    rigidBody.lastPosition = rigidBody.position;
    Vector2* positionDelta = [rigidBody.velocity vectorByMultiplication:timeDelta];
    rigidBody.position = [rigidBody.position vectorByAddingVector:positionDelta];
}

+(void)updateVelocityOfRigidBody:(RigidBody*)rigidBody
                   overTimeDelta:(double)timeDelta
{
    Vector2* velocityDelta = [rigidBody.acceleration vectorByMultiplication:timeDelta];
    rigidBody.velocity = [rigidBody.velocity vectorByAddingVector:velocityDelta];
}

+(void)updateGravityOfRigidBody:(RigidBody*)rigidBody
                  overTimeDelta:(double)timeDelta
{
    if(rigidBody.hasGravity)
    {
        rigidBody.acceleration.y = -100; // get ridda that magic number!
    }
}

@end
