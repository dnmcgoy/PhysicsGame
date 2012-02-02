#import "RigidBody.h"

@implementation RigidBody

@synthesize hasGravity;
@synthesize mass;
@synthesize friction;
@synthesize centerOfMass;
@synthesize position;
@synthesize lastPosition;
@synthesize velocity;
@synthesize acceleration;
@synthesize drag;
@synthesize rotation;
@synthesize lastRotation;
@synthesize rotationalVelocity;
@synthesize rotationalAcceleration;
@synthesize rotationalDrag;
@synthesize points;
@synthesize prevPoints;
@synthesize boundBox;
@synthesize lastIntersection;
@synthesize lastTile;

-(id)init
{
    if (self = [super init])
    {
        self.hasGravity = YES;
        self.mass = 1.0f;
        self.friction = 0;
        self.centerOfMass = [[Vector2 alloc] init];
        self.position = [[Vector2 alloc] init];
        self.lastPosition = [[Vector2 alloc] init];
        self.velocity = [[Vector2 alloc] init];
        self.acceleration = [[Vector2 alloc] init];
        self.drag = 0;
        self.rotation = 0;
        self.lastRotation = 0;
        self.rotationalVelocity = 0;
        self.rotationalAcceleration = 0;
        self.rotationalDrag = 0;
        
        self.points = [[NSMutableArray alloc] init];
        self.prevPoints = [[NSMutableArray alloc] init];
        self.boundBox = [[NSMutableArray alloc] init];
        self.lastIntersection = [[NSMutableArray alloc] init];
        self.lastTile = [[NSMutableArray alloc] init];
        
        // DELETE THIS
        [self.boundBox addObject:[[Vector2 alloc] initWithX:-25.0 andY:-25.0]];
        [self.boundBox addObject:[[Vector2 alloc] initWithX:0.0 andY:25.0]];
        [self.boundBox addObject:[[Vector2 alloc] initWithX:25.0 andY:-25.0]];
        [self.points addObjectsFromArray:self.boundBox];
    }
    
    return self;
}

-(void) updatePoints
{
	for(int i = 0; i < [self.boundBox count]; i++)
	{
        Vector2* point = [boundBox objectAtIndex:i];
		point = [point vectorByRotationInDegrees:rotation];
        point = [point vectorByAddingVector:position];
		[points replaceObjectAtIndex:i withObject:point];
	}
}

-(BOOL)containsPoint:(Vector2*)point
{
	// TODO: this will likely need to be adjusted
	if([position distanceToVector:point] > 100)
    {
		return false;
    }
    
	for(int i = 0; i < [points count]; i++)
	{
		Vector2* side;
		Vector2* pointVector;
        
		if(i == ([points count] - 1))
        {
			side = [(Vector2*)[points objectAtIndex:0] vectorBySubtractingVector:[points objectAtIndex:i]];
        }
		else
        {
            side = [(Vector2*)[points objectAtIndex:(i + 1)] vectorBySubtractingVector:[points objectAtIndex:i]];
        }
        
		pointVector = [point vectorBySubtractingVector:[points objectAtIndex:i]];
        
		if(![side isInteriorToVector:pointVector])
        {
			return NO;
        }
	}
    
	return YES;
}

@end
