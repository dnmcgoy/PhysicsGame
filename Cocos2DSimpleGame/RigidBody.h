#import <Foundation/Foundation.h>
#import "Vector2.h"

@interface RigidBody : NSObject

@property BOOL hasGravity;
@property double mass;
@property double friction;
@property (nonatomic, retain) Vector2* centerOfMass;
@property (nonatomic, retain) Vector2* position;
@property (nonatomic, retain) Vector2* lastPosition;
@property (nonatomic, retain) Vector2* velocity;
@property (nonatomic, retain) Vector2* acceleration;
@property double drag;
@property double rotation;
@property double lastRotation;
@property double rotationalVelocity;
@property double rotationalAcceleration;
@property double rotationalDrag;

@property (nonatomic, retain) NSMutableArray* points;		//points and prevPoints store the ACTUAL position of bounding box points
@property (nonatomic, retain) NSArray* prevPoints;
@property (nonatomic, retain) NSArray* boundBox;	//boundBox stores the points relative to the object.
@property (nonatomic, retain) NSArray* lastIntersection;
@property (nonatomic, retain) NSArray* lastTile;

@end
