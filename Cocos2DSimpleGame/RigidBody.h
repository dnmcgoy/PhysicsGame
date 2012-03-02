#import <Foundation/Foundation.h>
#import "Vector2.h"
#import "Tile.h"

@interface RigidBody : NSObject

-(id)initWithBoundingBox:(NSArray*)boundingBox andPosition:(Vector2*)pos;
-(void)storePreviousPoints;
-(void)updatePoints;
-(BOOL)containsPoint:(Vector2*)point;
-(void)calculateMomentOfInertia;

@property BOOL hasGravity;
@property double mass;
@property double momentOfInertia;
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
@property float elasticity;

@property (nonatomic, retain) NSMutableArray* points;		//points and prevPoints store the ACTUAL position of bounding box points
@property (nonatomic, retain) NSMutableArray* previousPoints;
@property (nonatomic, retain) NSMutableArray* boundBox;	//boundBox stores the points relative to the object.
@property (nonatomic, retain) NSMutableArray* lastIntersection;
@property (nonatomic, retain) NSMutableArray* lastTile;

@end
