#import <Foundation/Foundation.h>
#import "RigidBody.h"
#import "Collision.h"
#import "Map.h"
#import "Tile.h"
#import "Wall.h"
#import "VelocityPair.h"

#define GRAVITY -100
#define PI 3.14159

@interface Physics : NSObject

+(void)correctCollisionsBetweenMap:(Map*)map
                      andRigidBody:(RigidBody*)rigidBody
                     overTimeDelta:(double)timeDelta;

+(Collision*)getCollisionWhereRigidBody:(RigidBody*)rigidBody
                    isInsideOfWallOnMap:(Map*)map
                          overTimeDelta:(double)timeDelta;

+(Collision*)getCollisionWhereWallFromTile:(Tile*)tile
                       isInsideOfRigidBody:(RigidBody*)rigidBody
                             overTimeDelta:(double)timeDelta;

+(void)applyCollision:(Collision*)collision
          toRigidBody:(RigidBody*)rigidBody
        overTimeDelta:(double)timeDelta;

+(void)applyCorrections:(NSArray*)corrections
            toRigidBody:(RigidBody*)rigidBody
          overTimeDelta:(double)timeDelta;

+(VelocityPair*)applyImpulseToRigidBody:(RigidBody*)rigidBody
                                atPoint:(Vector3*)point
                             withNormal:(Vector3*)normal;


+(void)updatePositionOfRigidBody:(RigidBody*)rigidBody
                   overTimeDelta:(double)timeDelta;

+(void)updateVelocityOfRigidBody:(RigidBody*)rigidBody
                   overTimeDelta:(double)timeDelta;

+(void)updateRotationOfRigidBody:(RigidBody*)rigidBody
                   overTimeDelta:(double)timeDelta;

+(void)updateRotationalVelocityOfRigidBody:(RigidBody*)rigidBody
                             overTimeDelta:(double)timeDelta;

+(void)updateGravityOfRigidBody:(RigidBody*)rigidBody
                  overTimeDelta:(double)timeDelta;

+(void)updateDragOfRigidBody:(RigidBody*)rigidBody
               overTimeDelta:(double)timeDelta;

@end
